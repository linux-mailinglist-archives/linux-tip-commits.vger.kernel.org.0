Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4905307562
	for <lists+linux-tip-commits@lfdr.de>; Thu, 28 Jan 2021 13:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhA1L7w (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 28 Jan 2021 06:59:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34580 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhA1L7q (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 28 Jan 2021 06:59:46 -0500
Date:   Thu, 28 Jan 2021 11:59:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611835141;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BGEuwSNboDiyZ/BU59QnUC32kqSwFnS/E8nL29mj7YY=;
        b=CreLqvLWUX4yL9Ty5XYGZ8uf+wAS6E+NZdMDg+VFsOrDGCzVN+HRxQPqCKbtqrfexTEbQF
        Rc+eQcn3hQ8qKwN4tHQpq3ziRolkK4lYtv9FtJgT8e+ixNFhPJXTWdpdhQ5gxKqXCdUR0w
        Zcih6dxM0zrAQvcFuyPeNtRRWLTdrvn7sZhxV9z/73vN96kBBfXZpr1eSs6Y/Z2jYqT6hb
        1we8NHbI7yOadRAvcbSAGmAGIcCMU/9P0QAkjibP0NSZzyzXbUhdX9qK0oDcQ7pD5FDwNn
        nlXdOrJU92/MUP5ryN7kPAZ40CsmPbjWBZaYvg2vYATJG5xn9j1sZSaoqRbPzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611835141;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BGEuwSNboDiyZ/BU59QnUC32kqSwFnS/E8nL29mj7YY=;
        b=NOobTiqMJ2GCo+KKpkwYnghmjtzN8uGyE5E2GH0U0ZLEeCUZKxycsUPszh/PXq7rAbPtEf
        +veEDJuWZtZAMxBw==
From:   "tip-bot2 for Fangrui Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/build: Treat R_386_PLT32 relocation as R_386_PC32
Cc:     Arnd Bergmann <arnd@arndb.de>, Fangrui Song <maskray@google.com>,
        Borislav Petkov <bp@suse.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210127205600.1227437-1-maskray@google.com>
References: <20210127205600.1227437-1-maskray@google.com>
MIME-Version: 1.0
Message-ID: <161183514033.23325.16464186456601359972.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     bb73d07148c405c293e576b40af37737faf23a6a
Gitweb:        https://git.kernel.org/tip/bb73d07148c405c293e576b40af37737faf23a6a
Author:        Fangrui Song <maskray@google.com>
AuthorDate:    Wed, 27 Jan 2021 12:56:00 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 28 Jan 2021 12:24:06 +01:00

x86/build: Treat R_386_PLT32 relocation as R_386_PC32

This is similar to commit

  b21ebf2fb4cd ("x86: Treat R_X86_64_PLT32 as R_X86_64_PC32")

but for i386. As far as the kernel is concerned, R_386_PLT32 can be
treated the same as R_386_PC32.

R_386_PLT32/R_X86_64_PLT32 are PC-relative relocation types which
can only be used by branches. If the referenced symbol is defined
externally, a PLT will be used.

R_386_PC32/R_X86_64_PC32 are PC-relative relocation types which can be
used by address taking operations and branches. If the referenced symbol
is defined externally, a copy relocation/canonical PLT entry will be
created in the executable.

On x86-64, there is no PIC vs non-PIC PLT distinction and an
R_X86_64_PLT32 relocation is produced for both `call/jmp foo` and
`call/jmp foo@PLT` with newer (2018) GNU as/LLVM integrated assembler.
This avoids canonical PLT entries (st_shndx=0, st_value!=0).

On i386, there are 2 types of PLTs, PIC and non-PIC. Currently,
the GCC/GNU as convention is to use R_386_PC32 for non-PIC PLT and
R_386_PLT32 for PIC PLT. Copy relocations/canonical PLT entries
are possible ABI issues but GCC/GNU as will likely keep the status
quo because (1) the ABI is legacy (2) the change will drop a GNU
ld diagnostic for non-default visibility ifunc in shared objects.

clang-12 -fno-pic (since [1]) can emit R_386_PLT32 for compiler
generated function declarations, because preventing canonical PLT
entries is weighed over the rare ifunc diagnostic.

Further info for the more interested:

  https://github.com/ClangBuiltLinux/linux/issues/1210
  https://sourceware.org/bugzilla/show_bug.cgi?id=27169
  https://github.com/llvm/llvm-project/commit/a084c0388e2a59b9556f2de0083333232da3f1d6 [1]

 [ bp: Massage commit message. ]

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Fangrui Song <maskray@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Link: https://lkml.kernel.org/r/20210127205600.1227437-1-maskray@google.com
---
 arch/x86/kernel/module.c |  1 +
 arch/x86/tools/relocs.c  | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 34b153c..5e9a34b 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -114,6 +114,7 @@ int apply_relocate(Elf32_Shdr *sechdrs,
 			*location += sym->st_value;
 			break;
 		case R_386_PC32:
+		case R_386_PLT32:
 			/* Add the value, subtract its position */
 			*location += sym->st_value - (uint32_t)location;
 			break;
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index ce7188c..1c3a196 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -867,9 +867,11 @@ static int do_reloc32(struct section *sec, Elf_Rel *rel, Elf_Sym *sym,
 	case R_386_PC32:
 	case R_386_PC16:
 	case R_386_PC8:
+	case R_386_PLT32:
 		/*
-		 * NONE can be ignored and PC relative relocations don't
-		 * need to be adjusted.
+		 * NONE can be ignored and PC relative relocations don't need
+		 * to be adjusted. Because sym must be defined, R_386_PLT32 can
+		 * be treated the same way as R_386_PC32.
 		 */
 		break;
 
@@ -910,9 +912,11 @@ static int do_reloc_real(struct section *sec, Elf_Rel *rel, Elf_Sym *sym,
 	case R_386_PC32:
 	case R_386_PC16:
 	case R_386_PC8:
+	case R_386_PLT32:
 		/*
-		 * NONE can be ignored and PC relative relocations don't
-		 * need to be adjusted.
+		 * NONE can be ignored and PC relative relocations don't need
+		 * to be adjusted. Because sym must be defined, R_386_PLT32 can
+		 * be treated the same way as R_386_PC32.
 		 */
 		break;
 
