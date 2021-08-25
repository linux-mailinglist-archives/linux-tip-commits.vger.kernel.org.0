Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F753F733F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Aug 2021 12:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240190AbhHYK2r (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 25 Aug 2021 06:28:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53330 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239809AbhHYK2e (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 25 Aug 2021 06:28:34 -0400
Date:   Wed, 25 Aug 2021 10:27:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629887267;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=niT/hp54b8OXZ+6C9WbQT2NfS//DyP6nGSFm3WvepPw=;
        b=alz5uNOYGdJWQ2OZeiaLrbxQL8Mt+fqdcvBeB695l+p5eEMDG/jweJrvke9NJc90ee3eOI
        4HCRb/n1LwuIxdZ+Pl0glK1w9SQ7EOqMrzSJzv4o41IU+ybkEufGQ0bxAYgX70sbSoAUDb
        ssGHtLyer7ooiBbuR0KpL7lr2m+WpjDbx93BqNOyNBD7yDJK90PmjWjUktgToP3RUBRj0V
        zyOneYMoIZX/pfE/b8ZPaY9GtJTNRC8a28jKyBDinO52T21O3lNx3/Bz2JxayeQXevTLUG
        G+ekMwUytDJowfZ12OwL4gTfdTIxoZ0gUEokaU3mwEPfvwrI0MhELm/6nDJpzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629887267;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=niT/hp54b8OXZ+6C9WbQT2NfS//DyP6nGSFm3WvepPw=;
        b=28dP6W0W0eB6OW8gtRrjvq5ov8vvhxnBPM3RrarP45XEeMx1uRaEn35ExA1y51zqfZTEOl
        i+e5TVqasDfrORCw==
From:   "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/build: Move the install rule to arch/x86/Makefile
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210729140023.442101-2-masahiroy@kernel.org>
References: <20210729140023.442101-2-masahiroy@kernel.org>
MIME-Version: 1.0
Message-ID: <162988726613.25758.16870758298499204887.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     081551266d2fbf6ce69a30c13a355ee476b2e745
Gitweb:        https://git.kernel.org/tip/081551266d2fbf6ce69a30c13a355ee476b2e745
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Thu, 29 Jul 2021 23:00:23 +09:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 25 Aug 2021 11:57:38 +02:00

x86/build: Move the install rule to arch/x86/Makefile

Currently, the install target in arch/x86/Makefile descends into
arch/x86/boot/Makefile to invoke the shell script, but there is no
good reason to do so.

arch/x86/Makefile can run the shell script directly.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210729140023.442101-2-masahiroy@kernel.org
---
 arch/x86/Makefile      | 3 ++-
 arch/x86/boot/Makefile | 7 +------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1a7c10e..d82d014 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -259,7 +259,8 @@ $(BOOT_TARGETS): vmlinux
 
 PHONY += install
 install:
-	$(Q)$(MAKE) $(build)=$(boot) $@
+	$(CONFIG_SHELL) $(srctree)/$(boot)/install.sh $(KERNELRELEASE) \
+		$(KBUILD_IMAGE) System.map "$(INSTALL_PATH)"
 
 PHONY += vdso_install
 vdso_install:
diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index dfbc26a..b5aecb5 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -133,7 +133,7 @@ quiet_cmd_genimage = GENIMAGE $3
 cmd_genimage = $(BASH) $(srctree)/$(src)/genimage.sh $2 $3 $(obj)/bzImage \
 		$(obj)/mtools.conf '$(FDARGS)' $(FDINITRD)
 
-PHONY += bzdisk fdimage fdimage144 fdimage288 hdimage isoimage install
+PHONY += bzdisk fdimage fdimage144 fdimage288 hdimage isoimage
 
 # This requires write access to /dev/fd0
 # All images require syslinux to be installed; hdimage also requires
@@ -156,8 +156,3 @@ hdimage: $(imgdeps)
 isoimage: $(imgdeps)
 	$(call cmd,genimage,isoimage,$(obj)/image.iso)
 	@$(kecho) 'Kernel: $(obj)/image.iso is ready'
-
-install:
-	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh \
-		$(KERNELRELEASE) $(obj)/bzImage \
-		System.map "$(INSTALL_PATH)"
