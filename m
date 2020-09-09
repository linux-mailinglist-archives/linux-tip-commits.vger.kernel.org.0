Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6371B262981
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Sep 2020 10:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgIIIFh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Sep 2020 04:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730187AbgIIIE5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Sep 2020 04:04:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D00C061573;
        Wed,  9 Sep 2020 01:04:56 -0700 (PDT)
Date:   Wed, 09 Sep 2020 08:04:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599638687;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=d+ioUACl2XogbtfbKmzPVujemO1Zy7dQACxcaLLfuHE=;
        b=bNc1fjqSypKX2/WRZqvNYRmVr8MvcA4cfDbmDHJRUQuleKz4yiYS8ZL8yCTicMeM+O6Gt7
        kAgRplNl8YWr+qjg0O+R89egRIRQdteBIie1X0t0wOXsW1KGm2vGlN1UrzYx0WsDgLmsuI
        8t/ApdZYlID4Bp0iUQY33hIzauWIwGevBpHMV6RyMv0Z2YyfrdOVVkwV1L1iYq11WTVWC+
        CICf6TFHWlgq5QRR5JbR5QfsoXPXBQRRLr3bQDSFvhR/cH0m3ANHVyS1i82daNq8+EswHg
        tADNRLPyItC06nS8pHjsVh0t+MaO8s7YnjzAtiz7DhbUOHXvwfVQrPFEHQ0+2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599638687;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=d+ioUACl2XogbtfbKmzPVujemO1Zy7dQACxcaLLfuHE=;
        b=xbHWXfm3mj5a0l1V+WEw+QWsTBQjZWwQtN0pplBi+3wMpz21lHH7UWLW4dObLpJnqXTzu1
        ntmJwxNK41+aZdAg==
From:   tip-bot2 for Daniel =?utf-8?q?D=C3=ADaz?= <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/defconfigs: Explicitly unset CONFIG_64BIT in
 i386_defconfig
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>, daniel.diaz@linaro.org,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159963868645.20229.13058746616816561936.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     76366050eb1b3151c4b4110c76538ff14dffb74c
Gitweb:        https://git.kernel.org/tip/76366050eb1b3151c4b4110c76538ff14df=
fb74c
Author:        Daniel D=C3=ADaz <daniel.diaz@linaro.org>
AuthorDate:    Wed, 19 Aug 2020 12:32:24 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 09 Sep 2020 10:03:37 +02:00

x86/defconfigs: Explicitly unset CONFIG_64BIT in i386_defconfig

A recent refresh of the defconfigs got rid of the following
(unset) config:

  # CONFIG_64BIT is not set

Innocuous as it seems, when the config file is saved again the
behavior is changed so that CONFIG_64BIT=3Dy.

Currently,

  $ make i386_defconfig
  $ grep CONFIG_64BIT .config
  CONFIG_64BIT=3Dy

whereas previously (and with this patch):

  $ make i386_defconfig
  $ grep CONFIG_64BIT .config
  # CONFIG_64BIT is not set

( This was found with weird compiler errors on OpenEmbedded
  builds, as the compiler was unable to cope with 64-bits data
  types. )

Fixes: 1d0e12fd3a84 ("x86/defconfigs: Refresh defconfig files")
Reported-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Daniel D=C3=ADaz <daniel.diaz@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/configs/i386_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index d7577fe..4cfdf57 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -19,6 +19,7 @@ CONFIG_CGROUP_CPUACCT=3Dy
 CONFIG_BLK_DEV_INITRD=3Dy
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=3Dy
+# CONFIG_64BIT is not set
 CONFIG_SMP=3Dy
 CONFIG_X86_GENERIC=3Dy
 CONFIG_HPET_TIMER=3Dy
