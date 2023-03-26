import 'package:a_dollar_app/constants/footer.dart';
import 'package:a_dollar_app/theme.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    const emptyTextRow = Text("");
    const emptyTenPixels = SizedBox(
      height: 10,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        footerDivider(),
        emptyTenPixels,
        Text(
          "Disclamer:",
          style: Theme.of(context).textTheme.bodySmall,
        ),
        emptyTextRow,
        Text(
          FooterConstants.disclamer,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        emptyTextRow,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              FooterConstants.inspiredBy,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              FooterConstants.year,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        emptyTenPixels,
        emptyTenPixels,
      ],
    );
  }

  Widget footerDivider() {
    return Divider(
      thickness: 1,
      color: DollarTheme.pinkDivider,
    );
  }
}
