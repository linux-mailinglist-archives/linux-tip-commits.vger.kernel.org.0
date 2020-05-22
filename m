Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87871DE712
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 May 2020 14:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgEVMkm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 May 2020 08:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728717AbgEVMkl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 May 2020 08:40:41 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F506C061A0E;
        Fri, 22 May 2020 05:40:41 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jc6yV-00046F-3h; Fri, 22 May 2020 14:40:31 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B42D31C0095;
        Fri, 22 May 2020 14:40:28 +0200 (CEST)
Date:   Fri, 22 May 2020 12:40:28 -0000
From:   "tip-bot2 for Fangrui Song" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/boot: Discard .discard.unreachable for
 arch/x86/boot/compressed/vmlinux
Cc:     kbuild test robot <lkp@intel.com>,
        Fangrui Song <maskray@google.com>,
        Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Sedat Dilek <sedat.dilek@gmail.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200520182010.242489-1-maskray@google.com>
References: <20200520182010.242489-1-maskray@google.com>
MIME-Version: 1.0
Message-ID: <159015122855.17951.18280741242752343331.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     d6ee6529436a15a0541aff6e1697989ee7dc2c44
Gitweb:        https://git.kernel.org/tip/d6ee6529436a15a0541aff6e1697989ee7dc2c44
Author:        Fangrui Song <maskray@google.com>
AuthorDate:    Wed, 20 May 2020 11:20:10 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 22 May 2020 12:42:07 +02:00

x86/boot: Discard .discard.unreachable for arch/x86/boot/compressed/vmlinux

With commit

  ce5e3f909fc0 ("efi/printf: Add 64-bit and 8-bit integer support")

arch/x86/boot/compressed/vmlinux may have an undesired .discard.unreachable
section coming from drivers/firmware/efi/libstub/vsprintf.stub.o. That section
gets generated from unreachable() annotations when CONFIG_STACK_VALIDATION is
enabled.

.discard.unreachable contains an R_X86_64_PC32 relocation which will be
warned about by LLD: a non-SHF_ALLOC section (.discard.unreachable) is
not part of the memory image, thus conceptually the distance between a
non-SHF_ALLOC and a SHF_ALLOC is not a constant which can be resolved at
link time:

  % ld.lld -m elf_x86_64 -T arch/x86/boot/compressed/vmlinux.lds ... -o arch/x86/boot/compressed/vmlinux
  ld.lld: warning: vsprintf.c:(.discard.unreachable+0x0): has non-ABS relocation R_X86_64_PC32 against symbol ''

Reuse the DISCARDS macro which includes .discard.* to drop
.discard.unreachable.

 [ bp: Massage and complete the commit message. ]

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Fangrui Song <maskray@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Arvind Sankar <nivedita@alum.mit.edu>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Link: https://lkml.kernel.org/r/20200520182010.242489-1-maskray@google.com
---
 arch/x86/boot/compressed/vmlinux.lds.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 508cfa6..1031af1 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -73,4 +73,6 @@ SECTIONS
 #endif
 	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
 	_end = .;
+
+	DISCARDS
 }
