import 'package:flutter/material.dart';

typedef void RatingChangeCallback(double rating);

class RatingWidget extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback onRatingChanged;
  final Color color;
  final Color borderColor;
  final double size;
  final bool allowHalfRating;
  final bool verticalRatingText;
  final IconData filledIconData;
  final IconData halfFilledIconData;
  final IconData
  defaultIconData; //this is needed only when having fullRatedIconData && halfRatedIconData
  final double spacing;
  RatingWidget({
    this.starCount = 5,
    this.spacing = 0.0,
    this.rating = 0.0,
    this.defaultIconData,
    this.onRatingChanged,
    this.color,
    this.borderColor,
    this.size = 25,
    this.filledIconData,
    this.halfFilledIconData,
    this.allowHalfRating = true,
    this.verticalRatingText = false,
  }) {
    assert(this.rating != null);
  }

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = new Icon(
        defaultIconData != null ? defaultIconData : Icons.star_border,
        color: borderColor ?? Theme.of(context).primaryColor,
        size: size,
      );
    } else if (index > rating - (allowHalfRating ? 0.5 : 1.0) &&
        index < rating) {
      icon = new Icon(
        halfFilledIconData != null ? halfFilledIconData : Icons.star_half,
        color: color ?? Theme.of(context).primaryColor,
        size: size,
      );
    } else {
      icon = new Icon(
        filledIconData != null ? filledIconData : Icons.star,
        color: color ?? Theme.of(context).primaryColor,
        size: size,
      );
    }

    return new GestureDetector(
      onTap: () {
        if (this.onRatingChanged != null) onRatingChanged(index + 1.0);
      },
      onHorizontalDragUpdate: (dragDetails) {
        RenderBox box = context.findRenderObject();
        var _pos = box.globalToLocal(dragDetails.globalPosition);
        var i = _pos.dx / size;
        var newRating = allowHalfRating ? i : i.round().toDouble();
        if (newRating > starCount) {
          newRating = starCount.toDouble();
        }
        if (newRating < 0) {
          newRating = 0.0;
        }
        if (this.onRatingChanged != null) onRatingChanged(newRating);
      },
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (verticalRatingText) {
      return new Material(
          color: Colors.transparent,
          child: Column(
            children: [
              Text(
                rating.toString(),
                style: TextStyle(fontSize: size, fontWeight: FontWeight.bold),
              ),
              new Wrap(
                  alignment: WrapAlignment.start,
                  spacing: spacing,
                  children: new List.generate(
                      starCount, (index) => buildStar(context, index))),
            ],
          ));
    } else {
      return new Material(
          color: Colors.transparent,
          child: Row(
            children: [
              new Wrap(
                  alignment: WrapAlignment.start,
                  spacing: spacing,
                  children: new List.generate(
                      starCount, (index) => buildStar(context, index))),
              Text(
                rating.toString(),
                style: TextStyle(
                    fontSize: (size - 9), fontWeight: FontWeight.bold),
              )
            ],
          ));
    }
  }
}