Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75FD5195CAF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 27 Mar 2020 18:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgC0R13 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 27 Mar 2020 13:27:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54355 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0R13 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 27 Mar 2020 13:27:29 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jHslR-0002vB-Pc; Fri, 27 Mar 2020 18:27:25 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 57EB91C03AB;
        Fri, 27 Mar 2020 18:27:25 +0100 (CET)
Date:   Fri, 27 Mar 2020 17:27:24 -0000
From:   "tip-bot2 for H.J. Lu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] vmlinux.lds: Discard .note.gnu.property sections in
 generic NOTES
Cc:     "H.J. Lu" <hjl.tools@gmail.com>, Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200327121101.948934-1-hjl.tools@gmail.com>
References: <20200327121101.948934-1-hjl.tools@gmail.com>
MIME-Version: 1.0
Message-ID: <158533004496.28353.6659866597938496589.tip-bot2@tip-bot2>
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

Commit-ID:     72cb2113c1bbd82cf3e062a39ff2753ee9d3fae7
Gitweb:        https://git.kernel.org/tip/72cb2113c1bbd82cf3e062a39ff2753ee9d3fae7
Author:        H.J. Lu <hjl.tools@gmail.com>
AuthorDate:    Fri, 27 Mar 2020 05:11:01 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 27 Mar 2020 15:58:13 +01:00

vmlinux.lds: Discard .note.gnu.property sections in generic NOTES

With the command-line option, -mx86-used-note=yes, which can also be
enabled at binutils build time with

  --enable-x86-used-note  generate GNU x86 used ISA and feature properties

the x86 assembler in binutils 2.32 and above generates a program property
note in a note section, .note.gnu.property, to encode used x86 ISAs and
features.  But the kernel linker script only contains a single NOTE segment:

  PHDRS {
   text PT_LOAD FLAGS(5);
   data PT_LOAD FLAGS(6);
   percpu PT_LOAD FLAGS(6);
   init PT_LOAD FLAGS(7);
   note PT_NOTE FLAGS(0);
  }
  SECTIONS
  {
  ...
   .notes : AT(ADDR(.notes) - 0xffffffff80000000) { __start_notes = .; KEEP(*(.not
  e.*)) __stop_notes = .; } :text :note
  ...
  }

The NOTE segment generated by the kernel linker script is aligned to
4 bytes. But .note.gnu.property section must be aligned to 8 bytes on
x86-64, resulting in:

  [hjl@gnu-skx-1 linux]$ readelf -n vmlinux

  Displaying notes found in: .notes
    Owner                Data size Description
    Xen                  0x00000006 Unknown note type: (0x00000006)
     description data: 6c 69 6e 75 78 00
    Xen                  0x00000004 Unknown note type: (0x00000007)
     description data: 32 2e 36 00
    xen-3.0              0x00000005 Unknown note type: (0x006e6558)
     description data: 08 00 00 00 03
  readelf: Warning: note with invalid namesz and/or descsz found at offset 0x50
  readelf: Warning:  type: 0xffffffff, namesize: 0x006e6558, descsize:
  0x80000000, alignment: 8

Since note.gnu.property section in the kernel image is never used,
discard it.

 [ bp: Massage. ]

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20200327121101.948934-1-hjl.tools@gmail.com
---
 include/asm-generic/vmlinux.lds.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 2444336..998eafa 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -818,7 +818,14 @@
 #define TRACEDATA
 #endif
 
+/*
+ * Discard .note.gnu.property sections which are unused and have
+ * different alignment requirement from kernel note sections.
+ */
 #define NOTES								\
+	/DISCARD/ : {							\
+		*(.note.gnu.property)					\
+	}								\
 	.notes : AT(ADDR(.notes) - LOAD_OFFSET) {			\
 		__start_notes = .;					\
 		KEEP(*(.note.*))					\
