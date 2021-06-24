Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0499D3B2C39
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 12:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbhFXKSr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 24 Jun 2021 06:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbhFXKSr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 24 Jun 2021 06:18:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D1BC061574;
        Thu, 24 Jun 2021 03:16:28 -0700 (PDT)
Date:   Thu, 24 Jun 2021 10:16:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624529786;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hpfer/IanVe/6vT7BzlyfIhB+VTH9Mb4Ej9aBEzXSuQ=;
        b=VhDdtQ7cBNcbC/29Pxu67Y4WoWJdSdv0BnID162CUhw/IIOfaXDeo3PEVW2Et8++hxMO/5
        h+x8+Mf6utrtG/o6BJcOpdaspu8CJD4B3WtQUABOzGYbQqjbUzM01B562pAVaXGaNFbCBH
        o+QnXNEWuVDRVtHqmE6JtoVWUfyeWlCqXetO9WFIWahGNaR1vXBEj2SADALPz7jcloqPI0
        ouRcH5ZwVRyK1mZON3unYfMhXYERnpGZZRJxCY9J8oo2gSYDmq/kmLNuD0JMJdi/u7/Mw1
        fLWgcpqU2B53lgPTqdFuxTbJwfeqHeXpLzOJfMnw4uk/brNpssioSBLtk3sAXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624529786;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hpfer/IanVe/6vT7BzlyfIhB+VTH9Mb4Ej9aBEzXSuQ=;
        b=2agCN7FXUvi8jJ3oj2cSZVd9G/NTm6gGa7MM27i8nYMiqNdbmLLDg9tJ/6emR3nqXx3Ss3
        dJ4AU/hBVF8z3rAA==
From:   "tip-bot2 for Cassio Neri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time: Improve performance of time64_to_tm()
Cc:     Cassio Neri <cassio.neri@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210622213616.313046-1-cassio.neri@gmail.com>
References: <20210622213616.313046-1-cassio.neri@gmail.com>
MIME-Version: 1.0
Message-ID: <162452978551.395.2674108492300039420.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     276010551664f73b6f1616dde471d6f0d63a73ba
Gitweb:        https://git.kernel.org/tip/276010551664f73b6f1616dde471d6f0d63a73ba
Author:        Cassio Neri <cassio.neri@gmail.com>
AuthorDate:    Tue, 22 Jun 2021 22:36:16 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 24 Jun 2021 11:51:59 +02:00

time: Improve performance of time64_to_tm()

The current implementation of time64_to_tm() contains unnecessary loops,
branches and look-up tables. The new one uses an arithmetic-based algorithm
appeared in [1] and is approximately 3x faster (YMMV).

The drawback is that the new code isn't intuitive and contains many 'magic
numbers' (not unusual for this type of algorithm). However, [1] justifies
all those numbers and, given this function's history, the code is unlikely
to need much maintenance, if any at all.

Add a KUnit test for it which checks every day in a 160,000 years interval
centered at 1970-01-01 against the expected result.

[1] Neri, Schneider, "Euclidean Affine Functions and Applications to
Calendar Algorithms". https://arxiv.org/abs/2102.06959

Signed-off-by: Cassio Neri <cassio.neri@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210622213616.313046-1-cassio.neri@gmail.com
---
 kernel/time/Kconfig     |   9 +++-
 kernel/time/Makefile    |   1 +-
 kernel/time/time_test.c |  98 ++++++++++++++++++++++++++++++-
 kernel/time/timeconv.c  | 128 +++++++++++++++++++++------------------
 4 files changed, 178 insertions(+), 58 deletions(-)
 create mode 100644 kernel/time/time_test.c

diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 83e158d..3610b1b 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -64,6 +64,15 @@ config LEGACY_TIMER_TICK
 	  lack support for the generic clockevent framework.
 	  New platforms should use generic clockevents instead.
 
+config TIME_KUNIT_TEST
+	tristate "KUnit test for kernel/time functions" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable this option to test RTC library functions.
+
+	  If unsure, say N.
+
 if GENERIC_CLOCKEVENTS
 menu "Timers subsystem"
 
diff --git a/kernel/time/Makefile b/kernel/time/Makefile
index 1ed85b2..7e875e6 100644
--- a/kernel/time/Makefile
+++ b/kernel/time/Makefile
@@ -22,3 +22,4 @@ obj-$(CONFIG_DEBUG_FS)				+= timekeeping_debug.o
 obj-$(CONFIG_TEST_UDELAY)			+= test_udelay.o
 obj-$(CONFIG_TIME_NS)				+= namespace.o
 obj-$(CONFIG_TEST_CLOCKSOURCE_WATCHDOG)		+= clocksource-wdtest.o
+obj-$(CONFIG_TIME_KUNIT_TEST)			+= time_test.o
diff --git a/kernel/time/time_test.c b/kernel/time/time_test.c
new file mode 100644
index 0000000..341ebfa
--- /dev/null
+++ b/kernel/time/time_test.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: LGPL-2.1+
+
+#include <kunit/test.h>
+#include <linux/time.h>
+
+/*
+ * Traditional implementation of leap year evaluation.
+ */
+static bool is_leap(long year)
+{
+	return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
+}
+
+/*
+ * Gets the last day of a month.
+ */
+static int last_day_of_month(long year, int month)
+{
+	if (month == 2)
+		return 28 + is_leap(year);
+	if (month == 4 || month == 6 || month == 9 || month == 11)
+		return 30;
+	return 31;
+}
+
+/*
+ * Advances a date by one day.
+ */
+static void advance_date(long *year, int *month, int *mday, int *yday)
+{
+	if (*mday != last_day_of_month(*year, *month)) {
+		++*mday;
+		++*yday;
+		return;
+	}
+
+	*mday = 1;
+	if (*month != 12) {
+		++*month;
+		++*yday;
+		return;
+	}
+
+	*month = 1;
+	*yday  = 0;
+	++*year;
+}
+
+/*
+ * Checks every day in a 160000 years interval centered at 1970-01-01
+ * against the expected result.
+ */
+static void time64_to_tm_test_date_range(struct kunit *test)
+{
+	/*
+	 * 80000 years	= (80000 / 400) * 400 years
+	 *		= (80000 / 400) * 146097 days
+	 *		= (80000 / 400) * 146097 * 86400 seconds
+	 */
+	time64_t total_secs = ((time64_t) 80000) / 400 * 146097 * 86400;
+	long year = 1970 - 80000;
+	int month = 1;
+	int mdday = 1;
+	int yday = 0;
+
+	struct tm result;
+	time64_t secs;
+	s64 days;
+
+	for (secs = -total_secs; secs <= total_secs; secs += 86400) {
+
+		time64_to_tm(secs, 0, &result);
+
+		days = div_s64(secs, 86400);
+
+		#define FAIL_MSG "%05ld/%02d/%02d (%2d) : %ld", \
+			year, month, mdday, yday, days
+
+		KUNIT_ASSERT_EQ_MSG(test, year - 1900, result.tm_year, FAIL_MSG);
+		KUNIT_ASSERT_EQ_MSG(test, month - 1, result.tm_mon, FAIL_MSG);
+		KUNIT_ASSERT_EQ_MSG(test, mdday, result.tm_mday, FAIL_MSG);
+		KUNIT_ASSERT_EQ_MSG(test, yday, result.tm_yday, FAIL_MSG);
+
+		advance_date(&year, &month, &mdday, &yday);
+	}
+}
+
+static struct kunit_case time_test_cases[] = {
+	KUNIT_CASE(time64_to_tm_test_date_range),
+	{}
+};
+
+static struct kunit_suite time_test_suite = {
+	.name = "time_test_cases",
+	.test_cases = time_test_cases,
+};
+
+kunit_test_suite(time_test_suite);
diff --git a/kernel/time/timeconv.c b/kernel/time/timeconv.c
index 62e3b46..59b922c 100644
--- a/kernel/time/timeconv.c
+++ b/kernel/time/timeconv.c
@@ -22,47 +22,16 @@
 
 /*
  * Converts the calendar time to broken-down time representation
- * Based on code from glibc-2.6
  *
  * 2009-7-14:
  *   Moved from glibc-2.6 to kernel by Zhaolei<zhaolei@cn.fujitsu.com>
+ * 2021-06-02:
+ *   Reimplemented by Cassio Neri <cassio.neri@gmail.com>
  */
 
 #include <linux/time.h>
 #include <linux/module.h>
-
-/*
- * Nonzero if YEAR is a leap year (every 4 years,
- * except every 100th isn't, and every 400th is).
- */
-static int __isleap(long year)
-{
-	return (year) % 4 == 0 && ((year) % 100 != 0 || (year) % 400 == 0);
-}
-
-/* do a mathdiv for long type */
-static long math_div(long a, long b)
-{
-	return a / b - (a % b < 0);
-}
-
-/* How many leap years between y1 and y2, y1 must less or equal to y2 */
-static long leaps_between(long y1, long y2)
-{
-	long leaps1 = math_div(y1 - 1, 4) - math_div(y1 - 1, 100)
-		+ math_div(y1 - 1, 400);
-	long leaps2 = math_div(y2 - 1, 4) - math_div(y2 - 1, 100)
-		+ math_div(y2 - 1, 400);
-	return leaps2 - leaps1;
-}
-
-/* How many days come before each month (0-12). */
-static const unsigned short __mon_yday[2][13] = {
-	/* Normal years. */
-	{0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365},
-	/* Leap years. */
-	{0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 366}
-};
+#include <linux/kernel.h>
 
 #define SECS_PER_HOUR	(60 * 60)
 #define SECS_PER_DAY	(SECS_PER_HOUR * 24)
@@ -77,9 +46,11 @@ static const unsigned short __mon_yday[2][13] = {
  */
 void time64_to_tm(time64_t totalsecs, int offset, struct tm *result)
 {
-	long days, rem, y;
+	u32 u32tmp, day_of_century, year_of_century, day_of_year, month, day;
+	u64 u64tmp, udays, century, year;
+	bool is_Jan_or_Feb, is_leap_year;
+	long days, rem;
 	int remainder;
-	const unsigned short *ip;
 
 	days = div_s64_rem(totalsecs, SECS_PER_DAY, &remainder);
 	rem = remainder;
@@ -103,27 +74,68 @@ void time64_to_tm(time64_t totalsecs, int offset, struct tm *result)
 	if (result->tm_wday < 0)
 		result->tm_wday += 7;
 
-	y = 1970;
-
-	while (days < 0 || days >= (__isleap(y) ? 366 : 365)) {
-		/* Guess a corrected year, assuming 365 days per year. */
-		long yg = y + math_div(days, 365);
-
-		/* Adjust DAYS and Y to match the guessed year. */
-		days -= (yg - y) * 365 + leaps_between(y, yg);
-		y = yg;
-	}
-
-	result->tm_year = y - 1900;
-
-	result->tm_yday = days;
-
-	ip = __mon_yday[__isleap(y)];
-	for (y = 11; days < ip[y]; y--)
-		continue;
-	days -= ip[y];
-
-	result->tm_mon = y;
-	result->tm_mday = days + 1;
+	/*
+	 * The following algorithm is, basically, Proposition 6.3 of Neri
+	 * and Schneider [1]. In a few words: it works on the computational
+	 * (fictitious) calendar where the year starts in March, month = 2
+	 * (*), and finishes in February, month = 13. This calendar is
+	 * mathematically convenient because the day of the year does not
+	 * depend on whether the year is leap or not. For instance:
+	 *
+	 * March 1st		0-th day of the year;
+	 * ...
+	 * April 1st		31-st day of the year;
+	 * ...
+	 * January 1st		306-th day of the year; (Important!)
+	 * ...
+	 * February 28th	364-th day of the year;
+	 * February 29th	365-th day of the year (if it exists).
+	 *
+	 * After having worked out the date in the computational calendar
+	 * (using just arithmetics) it's easy to convert it to the
+	 * corresponding date in the Gregorian calendar.
+	 *
+	 * [1] "Euclidean Affine Functions and Applications to Calendar
+	 * Algorithms". https://arxiv.org/abs/2102.06959
+	 *
+	 * (*) The numbering of months follows tm more closely and thus,
+	 * is slightly different from [1].
+	 */
+
+	udays	= ((u64) days) + 2305843009213814918ULL;
+
+	u64tmp		= 4 * udays + 3;
+	century		= div64_u64_rem(u64tmp, 146097, &u64tmp);
+	day_of_century	= (u32) (u64tmp / 4);
+
+	u32tmp		= 4 * day_of_century + 3;
+	u64tmp		= 2939745ULL * u32tmp;
+	year_of_century	= upper_32_bits(u64tmp);
+	day_of_year	= lower_32_bits(u64tmp) / 2939745 / 4;
+
+	year		= 100 * century + year_of_century;
+	is_leap_year	= year_of_century ? !(year_of_century % 4) : !(century % 4);
+
+	u32tmp		= 2141 * day_of_year + 132377;
+	month		= u32tmp >> 16;
+	day		= ((u16) u32tmp) / 2141;
+
+	/*
+	 * Recall that January 1st is the 306-th day of the year in the
+	 * computational (not Gregorian) calendar.
+	 */
+	is_Jan_or_Feb	= day_of_year >= 306;
+
+	/* Convert to the Gregorian calendar and adjust to Unix time. */
+	year		= year + is_Jan_or_Feb - 6313183731940000ULL;
+	month		= is_Jan_or_Feb ? month - 12 : month;
+	day		= day + 1;
+	day_of_year	+= is_Jan_or_Feb ? -306 : 31 + 28 + is_leap_year;
+
+	/* Convert to tm's format. */
+	result->tm_year = (long) (year - 1900);
+	result->tm_mon  = (int) month;
+	result->tm_mday = (int) day;
+	result->tm_yday = (int) day_of_year;
 }
 EXPORT_SYMBOL(time64_to_tm);
