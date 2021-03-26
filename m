Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFB834A7DE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 26 Mar 2021 14:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhCZNOG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 26 Mar 2021 09:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhCZNNf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 26 Mar 2021 09:13:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCFFC0613B1;
        Fri, 26 Mar 2021 06:13:34 -0700 (PDT)
Date:   Fri, 26 Mar 2021 13:13:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616764411;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c17BCtUGHP4Z4iJZ0BvLOnKsdTiJ14hCmrJEoGbyCbk=;
        b=2C+CARMoctJqtHEswKpz52MLb+PpC4cmMtvq1iyD1DPzSP+mcFgn1NDmAIwOOsBsODhw0V
        ZCOzfeXkhEDP62gEvcUcM1zGswcx5dGMHgrrR91uCOlS2pLTWBJaHvzElMC3klfuhp3V6w
        RqeszRTlFX3FCG9C/nE7XnC94MbMkpAyRQj9tN+i4POvFlGnLOPMvnY6vF2aH8nyNcMWq0
        14DvoU4zDRHNwxptJG9Q1gOVwck3Zy+Enb8kwxRcpDg3KItdwvbiSr5XqacM7kVyc7MUVV
        vvZWQ3307WHJeEB171jjZ2lCYP5inMvA3gveCDDwHWpb7bC5axtawhZspQWamw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616764411;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c17BCtUGHP4Z4iJZ0BvLOnKsdTiJ14hCmrJEoGbyCbk=;
        b=DzB998pzJoaiTap5ROj/b865oRu3NXar0zka+/sTYww/ROFDCxvfPqtiDvkmwlP66QyV3S
        f0ZRMhuxWtn+VjDw==
From:   "tip-bot2 for John Millikin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/build: Propagate $(CLANG_FLAGS) to $(REALMODE_FLAGS)
Cc:     John Millikin <john@john-millikin.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Borislav Petkov <bp@suse.de>, Ard Biesheuvel <ardb@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210326000435.4785-2-nathan@kernel.org>
References: <20210326000435.4785-2-nathan@kernel.org>
MIME-Version: 1.0
Message-ID: <161676441085.398.3201409589926303297.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     8abe7fc26ad8f28bfdf78adbed56acd1fa93f82d
Gitweb:        https://git.kernel.org/tip/8abe7fc26ad8f28bfdf78adbed56acd1fa9=
3f82d
Author:        John Millikin <john@john-millikin.com>
AuthorDate:    Thu, 25 Mar 2021 17:04:33 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 26 Mar 2021 11:32:47 +01:00

x86/build: Propagate $(CLANG_FLAGS) to $(REALMODE_FLAGS)

When cross-compiling with Clang, the `$(CLANG_FLAGS)' variable
contains additional flags needed to build C and assembly sources
for the target platform. Normally this variable is automatically
included in `$(KBUILD_CFLAGS)' via the top-level Makefile.

The x86 real-mode makefile builds `$(REALMODE_CFLAGS)' from a
plain assignment and therefore drops the Clang flags. This causes
Clang to not recognize x86-specific assembler directives:

=C2=A0 arch/x86/realmode/rm/header.S:36:1: error: unknown directive
=C2=A0 .type real_mode_header STT_OBJECT ; .size real_mode_header, .-real_mod=
e_header
=C2=A0 ^

Explicit propagation of `$(CLANG_FLAGS)' to `$(REALMODE_CFLAGS)',
which is inherited by real-mode make rules, fixes cross-compilation
with Clang for x86 targets.

Relevant flags:

* `--target' sets the target architecture when cross-compiling. This
=C2=A0 flag must be set for both compilation and assembly (`KBUILD_AFLAGS')
=C2=A0 to support architecture-specific assembler directives.

* `-no-integrated-as' tells clang to assemble with GNU Assembler
=C2=A0 instead of its built-in LLVM assembler. This flag is set by default
=C2=A0 unless `LLVM_IAS=3D1' is set, because the LLVM assembler can't yet
=C2=A0 parse certain GNU extensions.

Signed-off-by: John Millikin <john@john-millikin.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Link: https://lkml.kernel.org/r/20210326000435.4785-2-nathan@kernel.org
---
 arch/x86/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 2d6d5a2..9a73e0c 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -33,6 +33,7 @@ REALMODE_CFLAGS +=3D -ffreestanding
 REALMODE_CFLAGS +=3D -fno-stack-protector
 REALMODE_CFLAGS +=3D $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -Wno-add=
ress-of-packed-member)
 REALMODE_CFLAGS +=3D $(call __cc-option, $(CC), $(REALMODE_CFLAGS), $(cc_sta=
ck_align4))
+REALMODE_CFLAGS +=3D $(CLANG_FLAGS)
 export REALMODE_CFLAGS
=20
 # BITS is used as extension for files which are available in a 32 bit
