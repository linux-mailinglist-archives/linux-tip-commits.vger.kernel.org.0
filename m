Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525AF38AFDB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 May 2021 15:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241654AbhETNZG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 20 May 2021 09:25:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46888 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237930AbhETNY6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 20 May 2021 09:24:58 -0400
Date:   Thu, 20 May 2021 13:23:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621517013;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1m/dLcsDfS6yRvunVzqXKS5CnPEpQ8UdIOHjzFXvIdE=;
        b=B1YBVIR52NNbJgCp8UB2Zyd3pjxqJHYrehTXK5nnfEZZAyd1x1HitYnQmDM10G9f9bsy3V
        KXZe88tUNB2doeF5eagLGA0BsyWaNzKymxDg81HThIIX4r9p/FWcx4kPKGowd+cgJFXX7k
        qrOvZ3XnYEOPUuqfNf0+sZRT9OdE1up1R3j/W/5NEWJtVhQL6iN2gMm+Ul/FCHZcc3UVeX
        hnuF9rx8egTWaix1NvoqYT8KozyKy746Zqg4Ey7L0ds0MH/WXN5NbaBSlhs4451XWGOhPG
        LIGLo5goEXgAgBLRnyOKv/k4rqfShMAij4Cu43Tk86DwGgYkYVwbEwuM5wSZbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621517013;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1m/dLcsDfS6yRvunVzqXKS5CnPEpQ8UdIOHjzFXvIdE=;
        b=G+a51cQ19JglkCHlcp6IFzwHesteHWDVSw00co/7XMjHgcERP4s+BdTsXyIbA4TPF+LlJD
        tTqUxhSzGIjB5UAg==
From:   "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/syscalls: Switch to generic syscallhdr.sh
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210517073815.97426-7-masahiroy@kernel.org>
References: <20210517073815.97426-7-masahiroy@kernel.org>
MIME-Version: 1.0
Message-ID: <162151701298.29796.16384412073039786695.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     3cba325b358f86357b5ce50eb9e6633183927eee
Gitweb:        https://git.kernel.org/tip/3cba325b358f86357b5ce50eb9e6633183927eee
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Mon, 17 May 2021 16:38:14 +09:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 20 May 2021 15:03:59 +02:00

x86/syscalls: Switch to generic syscallhdr.sh

Many architectures duplicate similar shell scripts.

Converts x86 to use scripts/syscallhdr.sh.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210517073815.97426-7-masahiroy@kernel.org
---
 arch/x86/entry/syscalls/Makefile      | 26 +++++++++----------
 arch/x86/entry/syscalls/syscallhdr.sh | 35 +--------------------------
 2 files changed, 13 insertions(+), 48 deletions(-)
 delete mode 100644 arch/x86/entry/syscalls/syscallhdr.sh

diff --git a/arch/x86/entry/syscalls/Makefile b/arch/x86/entry/syscalls/Makefile
index c4bd8dd..8eb014b 100644
--- a/arch/x86/entry/syscalls/Makefile
+++ b/arch/x86/entry/syscalls/Makefile
@@ -9,40 +9,40 @@ _dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)') \
 syscall32 := $(src)/syscall_32.tbl
 syscall64 := $(src)/syscall_64.tbl
 
-syshdr := $(srctree)/$(src)/syscallhdr.sh
+syshdr := $(srctree)/scripts/syscallhdr.sh
 systbl := $(srctree)/scripts/syscalltbl.sh
 
 quiet_cmd_syshdr = SYSHDR  $@
-      cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@' \
-		   '$(syshdr_abi_$(basetarget))' \
-		   '$(syshdr_pfx_$(basetarget))' \
-		   '$(syshdr_offset_$(basetarget))'
+      cmd_syshdr = $(CONFIG_SHELL) $(syshdr) --abis $(abis) --emit-nr \
+		$(if $(offset),--offset $(offset)) \
+		$(if $(prefix),--prefix $(prefix)) \
+		$< $@
 quiet_cmd_systbl = SYSTBL  $@
       cmd_systbl = $(CONFIG_SHELL) $(systbl) --abis $(abis) $< $@
 
 quiet_cmd_hypercalls = HYPERCALLS $@
       cmd_hypercalls = $(CONFIG_SHELL) '$<' $@ $(filter-out $<, $(real-prereqs))
 
-syshdr_abi_unistd_32 := i386
+$(uapi)/unistd_32.h: abis := i386
 $(uapi)/unistd_32.h: $(syscall32) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
-syshdr_abi_unistd_32_ia32 := i386
-syshdr_pfx_unistd_32_ia32 := ia32_
+$(out)/unistd_32_ia32.h: abis := i386
+$(out)/unistd_32_ia32.h: prefix := ia32_
 $(out)/unistd_32_ia32.h: $(syscall32) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
-syshdr_abi_unistd_x32 := common,x32
-syshdr_offset_unistd_x32 := __X32_SYSCALL_BIT
+$(uapi)/unistd_x32.h: abis := common,x32
+$(uapi)/unistd_x32.h: offset := __X32_SYSCALL_BIT
 $(uapi)/unistd_x32.h: $(syscall64) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
-syshdr_abi_unistd_64 := common,64
+$(uapi)/unistd_64.h: abis := common,64
 $(uapi)/unistd_64.h: $(syscall64) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
-syshdr_abi_unistd_64_x32 := x32
-syshdr_pfx_unistd_64_x32 := x32_
+$(out)/unistd_64_x32.h: abis := x32
+$(out)/unistd_64_x32.h: prefix := x32_
 $(out)/unistd_64_x32.h: $(syscall64) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
diff --git a/arch/x86/entry/syscalls/syscallhdr.sh b/arch/x86/entry/syscalls/syscallhdr.sh
deleted file mode 100644
index 75e66af..0000000
--- a/arch/x86/entry/syscalls/syscallhdr.sh
+++ /dev/null
@@ -1,35 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-in="$1"
-out="$2"
-my_abis=`echo "($3)" | tr ',' '|'`
-prefix="$4"
-offset="$5"
-
-fileguard=_ASM_X86_`basename "$out" | sed \
-    -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
-    -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
-grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
-    echo "#ifndef ${fileguard}"
-    echo "#define ${fileguard} 1"
-    echo ""
-
-    max=0
-    while read nr abi name entry ; do
-	if [ -z "$offset" ]; then
-	    echo "#define __NR_${prefix}${name} $nr"
-	else
-	    echo "#define __NR_${prefix}${name} ($offset + $nr)"
-        fi
-
-	max=$nr
-    done
-
-    echo ""
-    echo "#ifdef __KERNEL__"
-    echo "#define __NR_${prefix}syscalls $(($max + 1))"
-    echo "#endif"
-    echo ""
-    echo "#endif /* ${fileguard} */"
-) > "$out"
