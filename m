Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E0A35C4C9
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Apr 2021 13:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238947AbhDLLPt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 12 Apr 2021 07:15:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38482 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238912AbhDLLPt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 12 Apr 2021 07:15:49 -0400
Date:   Mon, 12 Apr 2021 11:15:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618226130;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Zaz73R9w1GqcZ3cTQvrV66yQlVChE6T2iNlE1h9BHg=;
        b=I+fVz3Ue+2r7baUlNIrNh2ke8fkboYoAzeowI8ZpZwTuZjzl86KvFvBO4F6rJRzLLdMvv4
        p9aK3H6Wca9fbs/cTJWPjArx3J8ap+w6i8sd9WAh+au7V4h11VQvLdGZ0PDmsjamyvXwdn
        dGsVYWoX4kVi/hLtXUUrVzj9RUZmjgFcY9Gnt6XwBRxRppbTiNY1qg+VvOoGYxCOqAkwmZ
        VWe++NCUiR+JNGRq2NVn2zmECFBMOYL8FAA7COEBVIVJvdiqJTQHPiCcW/wxwejKHjbi0t
        rwsrhHJ8rcbYwYHBdOAXFnVsdCHtw/Y7ct5+izWyRJO7quaCmWHPLojPPWOVQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618226130;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Zaz73R9w1GqcZ3cTQvrV66yQlVChE6T2iNlE1h9BHg=;
        b=YJPDvo5ZUfO9IgORMU6ifWpowpKhWzzPfXFUJkKC9hWQXggZcz+O+NWgaZ+TnL2eRRiW9Y
        moPRApkYP7A3fhAw==
From:   "tip-bot2 for Jan Kiszka" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/asm: Ensure asm/proto.h can be included stand-alone
Cc:     Jan Kiszka <jan.kiszka@siemens.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <b76b4be3-cf66-f6b2-9a6c-3e7ef54f9845@web.de>
References: <b76b4be3-cf66-f6b2-9a6c-3e7ef54f9845@web.de>
MIME-Version: 1.0
Message-ID: <161822612957.29796.15730791340399984286.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     f7b21a0e41171d22296b897dac6e4c41d2a3643c
Gitweb:        https://git.kernel.org/tip/f7b21a0e41171d22296b897dac6e4c41d2a=
3643c
Author:        Jan Kiszka <jan.kiszka@siemens.com>
AuthorDate:    Sun, 11 Apr 2021 10:12:16 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 12 Apr 2021 13:12:46 +02:00

x86/asm: Ensure asm/proto.h can be included stand-alone

Fix:

  ../arch/x86/include/asm/proto.h:14:30: warning: =E2=80=98struct task_struct=
=E2=80=99 declared \
    inside parameter list will not be visible outside of this definition or d=
eclaration
  long do_arch_prctl_64(struct task_struct *task, int option, unsigned long a=
rg2);
                               ^~~~~~~~~~~

  .../arch/x86/include/asm/proto.h:40:34: warning: =E2=80=98struct task_struc=
t=E2=80=99 declared \
    inside parameter list will not be visible outside of this definition or d=
eclaration
   long do_arch_prctl_common(struct task_struct *task, int option,
                                    ^~~~~~~~~~~

if linux/sched.h hasn't be included previously. This fixes a build error
when this header is used outside of the kernel tree.

 [ bp: Massage commit message. ]

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/b76b4be3-cf66-f6b2-9a6c-3e7ef54f9845@web.de
---
 arch/x86/include/asm/proto.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
index b6a9d51..8c5d191 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -4,6 +4,8 @@
=20
 #include <asm/ldt.h>
=20
+struct task_struct;
+
 /* misc architecture specific prototypes */
=20
 void syscall_init(void);
