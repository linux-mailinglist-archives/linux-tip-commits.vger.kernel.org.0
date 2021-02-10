Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A5031634E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 11:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhBJKJn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 05:09:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58084 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbhBJKHK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 05:07:10 -0500
Date:   Wed, 10 Feb 2021 10:06:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612951587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nJcrmQ57CHjcbwf0NnLOyiHFUbKWI4/RpoCBaREn3jo=;
        b=nO13LaRzePzGFiwKzBy03s9gVc6NdLg862ns9Jx/Rz6jQy6xYfAOstcF0gjVQQCKqhILZz
        7JzuJxnkGpChbWmTSbiIeni6gIkNy3w4pm7LrkKj+t/MfFvQBU83Rb0G5DD4+9JGurBR+8
        QrH3bMKxIRYGHPi2KXvLH48snRYkmejazq8TUVY7dyQXpTOzx2T0yx7UsPNJ/m5gTa639i
        0k6rRwZb9uZJC6P83kvjqlvcAF0x9IemVSqS37+zVWMnyyvF4KCxcvO+fbOI1dc7oZ+lCm
        UqxGdXwqMWdBfcuk8TNO8PWrjYZLCBN1QZnj2CPXYPgSOB3ggn8DHdMRpaNX6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612951587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nJcrmQ57CHjcbwf0NnLOyiHFUbKWI4/RpoCBaREn3jo=;
        b=pQhycNE1G48FrA8/p/DFuEEoz1iD6604X4OFoSwSF/uj1ZM+qOiiwHMGxtbg4LLkY/rjwz
        mJFGJEUOaFRwF+BA==
From:   "tip-bot2 for Bartosz Golaszewski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/davinci: Move pr_fmt() before
 the includes
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        David Lechner <david@lechnology.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210111140814.3668-1-brgl@bgdev.pl>
References: <20210111140814.3668-1-brgl@bgdev.pl>
MIME-Version: 1.0
Message-ID: <161295158523.23325.8387673102530314590.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     98509310e490bf3de13c96fbbbca8ef4af9db010
Gitweb:        https://git.kernel.org/tip/98509310e490bf3de13c96fbbbca8ef4af9db010
Author:        Bartosz Golaszewski <bgolaszewski@baylibre.com>
AuthorDate:    Mon, 11 Jan 2021 15:08:14 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 18 Jan 2021 16:31:39 +01:00

clocksource/drivers/davinci: Move pr_fmt() before the includes

We no longer need to undef pr_fmt if we define our own before including
any headers.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: David Lechner <david@lechnology.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210111140814.3668-1-brgl@bgdev.pl
---
 drivers/clocksource/timer-davinci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
index bb4eee3..9996c05 100644
--- a/drivers/clocksource/timer-davinci.c
+++ b/drivers/clocksource/timer-davinci.c
@@ -7,6 +7,8 @@
  * (with tiny parts adopted from code by Kevin Hilman <khilman@baylibre.com>)
  */
 
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
 #include <linux/clk.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
@@ -17,9 +19,6 @@
 
 #include <clocksource/timer-davinci.h>
 
-#undef pr_fmt
-#define pr_fmt(fmt) "%s: " fmt, __func__
-
 #define DAVINCI_TIMER_REG_TIM12			0x10
 #define DAVINCI_TIMER_REG_TIM34			0x14
 #define DAVINCI_TIMER_REG_PRD12			0x18
