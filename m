Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B388B316D3D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 18:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhBJRsQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 12:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbhBJRra (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 12:47:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2630BC061786;
        Wed, 10 Feb 2021 09:46:49 -0800 (PST)
Date:   Wed, 10 Feb 2021 17:45:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612979157;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v4Am4SmAafXRdVaYUhp3zUsQI+h7mE1mcn9be3guIk4=;
        b=jsOiD5/U2CTCZMZ5dfnx51WxtLoRsYA4AM34GcEAFMPdzhx+ncJStXmTdYEit2zH9QXAJo
        kblcaxbnlGkV0w1xZM5+7tVB8RcJb2Wf+TqmwdBI9YcBmDDatSizrbIP9qv7wYLCEomU6C
        l9G6yLbhN3DykFy8f7BHmNuKidboW65SavQHx5aErnNAk0bubuz4o4NunzmdmL1yEO2VS0
        vj+0UmpIe/5rwBxRN3J2a4SXNHScosHMhzjD4MQJQ4NwuJrLwcuSzjetgLGYueHhlDEeTn
        uYzqaRT1QHJqVtqcTPn/wLwX/xPQCJA34uJOmc9HAxcotYVVCypiaZCnHEBrvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612979157;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v4Am4SmAafXRdVaYUhp3zUsQI+h7mE1mcn9be3guIk4=;
        b=oBWqyKe5YnlH/UKV5Z6hxUxfsiJGDZkHh3LJAweWx/NigBNn4pH+XT8bw4H6ykteeM85zK
        AtElTJD4pZjJ1cBA==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/fault: Skip the AMD erratum #91 workaround on
 unaffected CPUs
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <477173b7784bc28afb3e53d76ae5ef143917e8dd.1612924255.git.luto@kernel.org>
References: <477173b7784bc28afb3e53d76ae5ef143917e8dd.1612924255.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <161297915659.23325.14450332847739422318.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     d24df8ecf9b6f81029f520ae7158a8670a28d70b
Gitweb:        https://git.kernel.org/tip/d24df8ecf9b6f81029f520ae7158a8670a2=
8d70b
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Tue, 09 Feb 2021 18:33:34 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 10 Feb 2021 13:38:12 +01:00

x86/fault: Skip the AMD erratum #91 workaround on unaffected CPUs

According to the Revision Guide for AMD Athlon=E2=84=A2 64 and AMD Opteron=E2=
=84=A2
Processors, only early revisions of family 0xF are affected. This will
avoid unnecessarily fetching instruction bytes before sending SIGSEGV to
user programs.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/477173b7784bc28afb3e53d76ae5ef143917e8dd.1612=
924255.git.luto@kernel.org
---
 arch/x86/mm/fault.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 441c3e9..818902b 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -106,6 +106,15 @@ check_prefetch_opcode(struct pt_regs *regs, unsigned cha=
r *instr,
 	}
 }
=20
+static bool is_amd_k8_pre_npt(void)
+{
+	struct cpuinfo_x86 *c =3D &boot_cpu_data;
+
+	return unlikely(IS_ENABLED(CONFIG_CPU_SUP_AMD) &&
+			c->x86_vendor =3D=3D X86_VENDOR_AMD &&
+			c->x86 =3D=3D 0xf && c->x86_model < 0x40);
+}
+
 static int
 is_prefetch(struct pt_regs *regs, unsigned long error_code, unsigned long ad=
dr)
 {
@@ -113,6 +122,10 @@ is_prefetch(struct pt_regs *regs, unsigned long error_co=
de, unsigned long addr)
 	unsigned char *instr;
 	int prefetch =3D 0;
=20
+	/* Erratum #91 affects AMD K8, pre-NPT CPUs */
+	if (!is_amd_k8_pre_npt())
+		return 0;
+
 	/*
 	 * If it was a exec (instruction fetch) fault on NX page, then
 	 * do not ignore the fault:
