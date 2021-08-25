Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDCC3F7340
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Aug 2021 12:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240350AbhHYK2s (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 25 Aug 2021 06:28:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53338 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240209AbhHYK2e (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 25 Aug 2021 06:28:34 -0400
Date:   Wed, 25 Aug 2021 10:27:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629887267;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ic40rgXTTlf8xuFTsD8nmQPSBg9mUFyx0Dz0orJkp8I=;
        b=D0LptYRa4JkznEu6hgidPlsf/O81RygzlNnAJaImsydBCZeXqQnOJMFymotPgc7P736x97
        xeOqEDB74w14CxJA+WdVJHuWFsI0sTnDbrFXOyy0o6+BJ7pcdhPpB2SB/IP0lzIBDDQVdP
        dBYxm3VIHU617hbI1ajKxF5s3CCTqRfQeoYvV5AUmFG1JvU9SoC5IfgOgQIs2heBL/ZE0K
        khd6jqvfi6j5sW8pD/8CoZPnXT/77nkddC8VvkIGvRF3gwih9CcsFoTmjfKubvsNyZ5f0V
        NDfMi+9Rr7qP7XYkt42G40eFEOaRMMQT5PXxeABVy2ZIl9e87Vn70Qf85qGFpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629887267;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ic40rgXTTlf8xuFTsD8nmQPSBg9mUFyx0Dz0orJkp8I=;
        b=ZlzTcjj5CAXnzFD+j1RTQkxE9dUGnIk6DuCzZaNV28Cr2g6vU+K9jZP21ma8pTHCgXXW4B
        4d0wlTqxRUlH0vBQ==
From:   "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/build: Remove the left-over bzlilo target
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210729140023.442101-1-masahiroy@kernel.org>
References: <20210729140023.442101-1-masahiroy@kernel.org>
MIME-Version: 1.0
Message-ID: <162988726701.25758.14422750607277041101.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     6d61b8e66d343d61b650f9a2ca4d8746dc6cf774
Gitweb:        https://git.kernel.org/tip/6d61b8e66d343d61b650f9a2ca4d8746dc6cf774
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Thu, 29 Jul 2021 23:00:22 +09:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 25 Aug 2021 11:49:21 +02:00

x86/build: Remove the left-over bzlilo target

Commit

  f279b49f13bd ("x86/boot: Modernize genimage script; hdimage+EFI support")

removed the bzlilo target from arch/x86/boot/Makefile.

Remove the left-over from arch/x86/Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210729140023.442101-1-masahiroy@kernel.org
---
 arch/x86/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 88fb2bc..1a7c10e 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -257,8 +257,8 @@ endif
 $(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $@
 
-PHONY += install bzlilo
-install bzlilo:
+PHONY += install
+install:
 	$(Q)$(MAKE) $(build)=$(boot) $@
 
 PHONY += vdso_install
