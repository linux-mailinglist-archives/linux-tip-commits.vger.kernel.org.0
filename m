Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51AA71B1692
	for <lists+linux-tip-commits@lfdr.de>; Mon, 20 Apr 2020 22:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgDTUDJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 20 Apr 2020 16:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgDTUDI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 20 Apr 2020 16:03:08 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32C4C061A10;
        Mon, 20 Apr 2020 13:03:08 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jQcdF-00060v-CF; Mon, 20 Apr 2020 22:03:05 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F1C7B1C0483;
        Mon, 20 Apr 2020 22:03:04 +0200 (CEST)
Date:   Mon, 20 Apr 2020 20:03:04 -0000
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/core] x86/elf: Add table to document READ_IMPLIES_EXEC
Cc:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>,
        Jason Gunthorpe <jgg@mellanox.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200327064820.12602-2-keescook@chromium.org>
References: <20200327064820.12602-2-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <158741298454.28353.11194052681441645315.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/core branch of tip:

Commit-ID:     9d9e435f3f2492bfd196acacb61cc9a9212d8170
Gitweb:        https://git.kernel.org/tip/9d9e435f3f2492bfd196acacb61cc9a9212d8170
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Thu, 26 Mar 2020 23:48:15 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 20 Apr 2020 15:28:40 +02:00

x86/elf: Add table to document READ_IMPLIES_EXEC

Add a table to document the current behavior of READ_IMPLIES_EXEC in
preparation for changing the behavior.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Link: https://lkml.kernel.org/r/20200327064820.12602-2-keescook@chromium.org
---
 arch/x86/include/asm/elf.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 69c0f89..ee459d4 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -281,6 +281,25 @@ extern u32 elf_hwcap2;
 /*
  * An executable for which elf_read_implies_exec() returns TRUE will
  * have the READ_IMPLIES_EXEC personality flag set automatically.
+ *
+ * The decision process for determining the results are:
+ *
+ *                 CPU: | lacks NX*  | has NX, ia32     | has NX, x86_64 |
+ * ELF:                 |            |                  |                |
+ * ---------------------|------------|------------------|----------------|
+ * missing PT_GNU_STACK | exec-all   | exec-all         | exec-all       |
+ * PT_GNU_STACK == RWX  | exec-all   | exec-all         | exec-all       |
+ * PT_GNU_STACK == RW   | exec-none  | exec-none        | exec-none      |
+ *
+ *  exec-all  : all PROT_READ user mappings are executable, except when
+ *              backed by files on a noexec-filesystem.
+ *  exec-none : only PROT_EXEC user mappings are executable.
+ *
+ *  *this column has no architectural effect: NX markings are ignored by
+ *   hardware, but may have behavioral effects when "wants X" collides with
+ *   "cannot be X" constraints in memory permission flags, as in
+ *   https://lkml.kernel.org/r/20190418055759.GA3155@mellanox.com
+ *
  */
 #define elf_read_implies_exec(ex, executable_stack)	\
 	(executable_stack != EXSTACK_DISABLE_X)
