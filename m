Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44F53FF47D
	for <lists+linux-tip-commits@lfdr.de>; Thu,  2 Sep 2021 22:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243119AbhIBUCs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 2 Sep 2021 16:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243699AbhIBUCp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 2 Sep 2021 16:02:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC1DC061575;
        Thu,  2 Sep 2021 13:01:46 -0700 (PDT)
Date:   Thu, 02 Sep 2021 20:01:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630612905;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nKqhmry3tcl7EBL7AhD/CKgMfo8ukKXy8ENd4JPactY=;
        b=H90QqLU2YaFTxmGl6yEVfQqB+INzQtfpZUl9lznsLQ9eCkGKTB8MgkKHyEbdYiHvscts6y
        /JZNl+Xy9lCjsGm8eQeiCtc3iHRo23NbRY+W00rnIkjNfL1t5l2sJSE+hDNjdlxg7aUlZ/
        fiNfb1TXh3344CXIEpVg9+UohBqRANmZ0iSYHgDJecd+ugi1bD7AQits/uhy2FuS7J+yRY
        S0ODy/siC5c6fueFrUnYU/Y62xEle2nlZw2qD6D2K5XIvG1ktxlMsaYpLsXD1zYaS0lYG3
        Eddfl2SoIOtkkfqkIb2W1Z7GHHXCmoQ9RnQF9iKT3gEcpFDD0ZfltTj7EdStKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630612905;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nKqhmry3tcl7EBL7AhD/CKgMfo8ukKXy8ENd4JPactY=;
        b=9712TxCSRm8IE3BfIkzng1GD4yPJyFnmF3esnqSe3yap7UetFG68TtYeGa/mEWr10ioE87
        ftpLoy0DBETp/UBg==
From:   "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/platform: Increase maximum GPIO number for X86_64
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210826150317.29435-1-andriy.shevchenko@linux.intel.com>
References: <20210826150317.29435-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Message-ID: <163061290388.25758.6559432378047396977.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d7109fe3a0991a0f7b4ac099b78c908e3b619787
Gitweb:        https://git.kernel.org/tip/d7109fe3a0991a0f7b4ac099b78c908e3b619787
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Thu, 26 Aug 2021 18:03:17 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 02 Sep 2021 21:57:57 +02:00

x86/platform: Increase maximum GPIO number for X86_64

By default the 512 GPIOs is the maximum on any x86 platform.
With, for example, Intel Tiger Lake-H the SoC based controller
occupies up to 480 pins. This leaves only 32 available for
GPIO expanders or other drivers, like PMIC. Hence, bump the
maximum GPIO number to 1024 for X86_64 and leave 512 for X86_32.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/20210826150317.29435-1-andriy.shevchenko@linux.intel.com

---
 arch/x86/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 421fa9e..1016388 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -340,6 +340,11 @@ config NEED_PER_CPU_PAGE_FIRST_CHUNK
 config ARCH_HIBERNATION_POSSIBLE
 	def_bool y
 
+config ARCH_NR_GPIO
+	int
+	default 1024 if X86_64
+	default 512
+
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 
