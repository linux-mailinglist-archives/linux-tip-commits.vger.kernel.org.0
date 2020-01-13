Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 614FB1399A6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 13 Jan 2020 20:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgAMTJq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 13 Jan 2020 14:09:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39921 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728883AbgAMTJp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 13 Jan 2020 14:09:45 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ir55f-0000z3-U3; Mon, 13 Jan 2020 20:09:32 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C88111C18E1;
        Mon, 13 Jan 2020 20:09:27 +0100 (CET)
Date:   Mon, 13 Jan 2020 19:09:27 -0000
From:   "tip-bot2 for Dmitry Safonov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] x86/vdso: Restrict splitting VVAR VMA
Cc:     Andrei Vagin <avagin@openvz.org>, Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191112012724.250792-20-dima@arista.com>
References: <20191112012724.250792-20-dima@arista.com>
MIME-Version: 1.0
Message-ID: <157894256767.19145.15296635824788335791.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     35825d690265b6433faa2ba47fa7669ea7e125eb
Gitweb:        https://git.kernel.org/tip/35825d690265b6433faa2ba47fa7669ea7e125eb
Author:        Dmitry Safonov <dima@arista.com>
AuthorDate:    Tue, 12 Nov 2019 01:27:08 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 13 Jan 2020 08:10:54 +01:00

x86/vdso: Restrict splitting VVAR VMA

Forbid splitting VVAR VMA resulting in a stricter ABI and reducing the
amount of corner-cases to consider while working further on VDSO time
namespace support.

As the offset from timens to VVAR page is computed compile-time, the pages
in VVAR should stay together and not being partically mremap()'ed.

Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20191112012724.250792-20-dima@arista.com

---
 arch/x86/entry/vdso/vma.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index f593774..76cbe54 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -84,6 +84,18 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
 	return 0;
 }
 
+static int vvar_mremap(const struct vm_special_mapping *sm,
+		struct vm_area_struct *new_vma)
+{
+	const struct vdso_image *image = new_vma->vm_mm->context.vdso_image;
+	unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
+
+	if (new_size != -image->sym_vvar_start)
+		return -EINVAL;
+
+	return 0;
+}
+
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 		      struct vm_area_struct *vma, struct vm_fault *vmf)
 {
@@ -136,6 +148,7 @@ static const struct vm_special_mapping vdso_mapping = {
 static const struct vm_special_mapping vvar_mapping = {
 	.name = "[vvar]",
 	.fault = vvar_fault,
+	.mremap = vvar_mremap,
 };
 
 /*
