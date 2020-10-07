Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6994328635C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Oct 2020 18:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgJGQOw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Oct 2020 12:14:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44574 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgJGQOw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Oct 2020 12:14:52 -0400
Date:   Wed, 07 Oct 2020 16:14:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602087290;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9NAWPFMQ78nn6OFBQQhe7rxPuuYfr1VWEK6+zdtfnZw=;
        b=RheNZW6++FSKI1CknbqGaHEVyMkeDL5TTVL2793cGCgRDQsB7WBcHX1/mGz1SOhvGJ2G6e
        HBdPZr9mMSyamnRTeMTdwzfG9A9g7QCEtp+oZlzzIO+kZ0SLD4vTwTkweAffx2pkprUXOT
        pYeRxHpGzwyqxVNMxV+1bgOABjSbzZCMwlNp+j0cUksq+xqrv6avSqULmcdE/4anwOR655
        7S+eFOaDkJ/ZmYgG/d5WsPKvm6EgsES3b6u/sZ80kQz4Hbg7Vtx3wvemhx623gSp593UmV
        Mnmz5tA27Weao7a1BNDr58gieynXKgN8lp2YxdZ0KGHIKfDiCoDQShjDFcoVTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602087290;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9NAWPFMQ78nn6OFBQQhe7rxPuuYfr1VWEK6+zdtfnZw=;
        b=Es98l++RorZ1oJk7+dQEWFvUAwVK1uCQfAsCAI6OQ5d6dDvovYuNWSx9CZ92k+1Qvb2e4r
        ddAmjiFATKLizjBg==
From:   "tip-bot2 for Dave Jiang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/pasid] x86/asm: Add an enqcmds() wrapper for the ENQCMDS
 instruction
Cc:     Dave Jiang <dave.jiang@intel.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200924180041.34056-3-dave.jiang@intel.com>
References: <20200924180041.34056-3-dave.jiang@intel.com>
MIME-Version: 1.0
Message-ID: <160208728918.7002.3071969717527586062.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/pasid branch of tip:

Commit-ID:     7f5933f81bd85a0bf6a87d65c7327ea048a75e54
Gitweb:        https://git.kernel.org/tip/7f5933f81bd85a0bf6a87d65c7327ea048a=
75e54
Author:        Dave Jiang <dave.jiang@intel.com>
AuthorDate:    Mon, 05 Oct 2020 08:11:23 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 07 Oct 2020 17:53:08 +02:00

x86/asm: Add an enqcmds() wrapper for the ENQCMDS instruction

Currently, the MOVDIR64B instruction is used to atomically submit
64-byte work descriptors to devices. Although it can encounter errors
like device queue full, command not accepted, device not ready, etc when
writing to a device MMIO, MOVDIR64B can not report back on errors from
the device itself. This means that MOVDIR64B users need to separately
interact with a device to see if a descriptor was successfully queued,
which slows down device interactions.

ENQCMD and ENQCMDS also atomically submit 64-byte work descriptors
to devices. But, they *can* report back errors directly from the
device, such as if the device was busy, or device not enabled or does
not support the command. This immediate feedback from the submission
instruction itself reduces the number of interactions with the device
and can greatly increase efficiency.

ENQCMD can be used at any privilege level, but can effectively only
submit work on behalf of the current process. ENQCMDS is a ring0-only
instruction and can explicitly specify a process context instead of
being tied to the current process or needing to reprogram the IA32_PASID
MSR.

Use ENQCMDS for work submission within the kernel because a Process
Address ID (PASID) is setup to translate the kernel virtual address
space. This PASID is provided to ENQCMDS from the descriptor structure
submitted to the device and not retrieved from IA32_PASID MSR, which is
setup for the current user address space.

See Intel Software Developer=E2=80=99s Manual for more information on the
instructions.

 [ bp:
   - Make operand constraints like movdir64b() because both insns are
     basically doing the same thing, more or less.
   - Fixup comments and cleanup. ]

Link: https://lkml.kernel.org/r/20200924180041.34056-3-dave.jiang@intel.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20201005151126.657029-3-dave.jiang@intel.com
---
 arch/x86/include/asm/special_insns.h | 42 +++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/spec=
ial_insns.h
index d4baa0e..5482c2d 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -256,6 +256,48 @@ static inline void movdir64b(void *dst, const void *src)
 		     :  "m" (*__src), "a" (__dst), "d" (__src));
 }
=20
+/**
+ * enqcmds - Enqueue a command in supervisor (CPL0) mode
+ * @dst: destination, in MMIO space (must be 512-bit aligned)
+ * @src: 512 bits memory operand
+ *
+ * The ENQCMDS instruction allows software to write a 512-bit command to
+ * a 512-bit-aligned special MMIO region that supports the instruction.
+ * A return status is loaded into the ZF flag in the RFLAGS register.
+ * ZF =3D 0 equates to success, and ZF =3D 1 indicates retry or error.
+ *
+ * This function issues the ENQCMDS instruction to submit data from
+ * kernel space to MMIO space, in a unit of 512 bits. Order of data access
+ * is not guaranteed, nor is a memory barrier performed afterwards. It
+ * returns 0 on success and -EAGAIN on failure.
+ *
+ * Warning: Do not use this helper unless your driver has checked that the
+ * ENQCMDS instruction is supported on the platform and the device accepts
+ * ENQCMDS.
+ */
+static inline int enqcmds(void __iomem *dst, const void *src)
+{
+	const struct { char _[64]; } *__src =3D src;
+	struct { char _[64]; } *__dst =3D dst;
+	int zf;
+
+	/*
+	 * ENQCMDS %(rdx), rax
+	 *
+	 * See movdir64b()'s comment on operand specification.
+	 */
+	asm volatile(".byte 0xf3, 0x0f, 0x38, 0xf8, 0x02, 0x66, 0x90"
+		     CC_SET(z)
+		     : CC_OUT(z) (zf), "+m" (*__dst)
+		     : "m" (*__src), "a" (__dst), "d" (__src));
+
+	/* Submission failure is indicated via EFLAGS.ZF=3D1 */
+	if (zf)
+		return -EAGAIN;
+
+	return 0;
+}
+
 #endif /* __KERNEL__ */
=20
 #endif /* _ASM_X86_SPECIAL_INSNS_H */
