Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0682E69BF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Dec 2020 18:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgL1RcX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 28 Dec 2020 12:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbgL1RcW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 28 Dec 2020 12:32:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D080BC061796;
        Mon, 28 Dec 2020 09:31:41 -0800 (PST)
Date:   Mon, 28 Dec 2020 17:31:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1609176699;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rp2hmtzdwNqOlRd+jHcdZuHF2Sq1ESHpdEGqoRBejMI=;
        b=YsAxoRVVwumvK3fBu9jw0b4hItPDD3ENMBvCu9JcZr4xRHiOdB5dqigyop5c9Q5l8ZVuj2
        nNEH9JsZZQAlwE+LWskESQLlB8HRKxwcK403dHAS0tI+xNqK25hLmBi7zqGLNPmBcLIWPt
        QUW3/R3OFi4HVr3y2natJJdhoPmmQt1vF1+AAR31UFVESZJ/4D3MWVhg8MoU8LvJhtDmpV
        8evPquyaLFXV56zj+bEErcU87W+0b8onXb29qOxQ6UDbAXuyCBjnHZvNyyGbGAkC9ss2mJ
        GcNJcJcct+n2UL2HgcmMUn4q+3wiF1CLRytGe8ZIrmCZDoocGM5xsmcdPWspBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1609176699;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rp2hmtzdwNqOlRd+jHcdZuHF2Sq1ESHpdEGqoRBejMI=;
        b=w9otdPTOl+2VNPGnZfJuu375QyO+hyFOtX+Af/l4KsRoT6HcHHEvIvyuaycVFVcq2zQhH7
        izFQ45rA6Ec5zkAQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/build: Realign archhelp
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201217134608.31811-2-bp@alien8.de>
References: <20201217134608.31811-2-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <160917669777.414.8237968960616891230.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     ac5d08870d0b94cbfa8103c9e294de2b96f249bc
Gitweb:        https://git.kernel.org/tip/ac5d08870d0b94cbfa8103c9e294de2b96f249bc
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 17 Dec 2020 14:42:00 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 28 Dec 2020 18:25:53 +01:00

x86/build: Realign archhelp

Realign help text vertically and add spacing so that the target help
text is properly separated.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201217134608.31811-2-bp@alien8.de
---
 arch/x86/Makefile | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 3dae5c9..32dcddd 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -292,19 +292,20 @@ archclean:
 	$(Q)$(MAKE) $(clean)=arch/x86/tools
 
 define archhelp
-  echo  '* bzImage      - Compressed kernel image (arch/x86/boot/bzImage)'
-  echo  '  install      - Install kernel using'
-  echo  '                  (your) ~/bin/$(INSTALLKERNEL) or'
-  echo  '                  (distribution) /sbin/$(INSTALLKERNEL) or'
-  echo  '                  install to $$(INSTALL_PATH) and run lilo'
-  echo  '  fdimage      - Create 1.4MB boot floppy image (arch/x86/boot/fdimage)'
-  echo  '  fdimage144   - Create 1.4MB boot floppy image (arch/x86/boot/fdimage)'
-  echo  '  fdimage288   - Create 2.8MB boot floppy image (arch/x86/boot/fdimage)'
-  echo  '  isoimage     - Create a boot CD-ROM image (arch/x86/boot/image.iso)'
-  echo  '                  bzdisk/fdimage*/isoimage also accept:'
-  echo  '                  FDARGS="..."  arguments for the booted kernel'
-  echo  '                  FDINITRD=file initrd for the booted kernel'
-  echo  '  kvm_guest.config - Enable Kconfig items for running this kernel as a KVM guest'
-  echo  '  xen.config	  - Enable Kconfig items for running this kernel as a Xen guest'
+  echo  '* bzImage		- Compressed kernel image (arch/x86/boot/bzImage)'
+  echo  '  install		- Install kernel using (your) ~/bin/$(INSTALLKERNEL) or'
+  echo  '			  (distribution) /sbin/$(INSTALLKERNEL) or install to '
+  echo  '			  $$(INSTALL_PATH) and run lilo'
+  echo  ''
+  echo  '  fdimage		- Create 1.4MB boot floppy image (arch/x86/boot/fdimage)'
+  echo  '  fdimage144		- Create 1.4MB boot floppy image (arch/x86/boot/fdimage)'
+  echo  '  fdimage288		- Create 2.8MB boot floppy image (arch/x86/boot/fdimage)'
+  echo  '  isoimage		- Create a boot CD-ROM image (arch/x86/boot/image.iso)'
+  echo  '			  bzdisk/fdimage*/isoimage also accept:'
+  echo  '			  FDARGS="..."  arguments for the booted kernel'
+  echo  '                  	  FDINITRD=file initrd for the booted kernel'
+  echo  ''
+  echo  '  kvm_guest.config	- Enable Kconfig items for running this kernel as a KVM guest'
+  echo  '  xen.config		- Enable Kconfig items for running this kernel as a Xen guest'
 
 endef
