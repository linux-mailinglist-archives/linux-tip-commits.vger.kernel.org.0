Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC002C29E5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Nov 2020 15:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389056AbgKXOmO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Nov 2020 09:42:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43850 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388162AbgKXOmO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Nov 2020 09:42:14 -0500
Date:   Tue, 24 Nov 2020 14:42:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606228932;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ATsDejaPv8NkLKCC6exgYHw07pd1pomeYiGhekbJbps=;
        b=EHINuUXgetx03zYlcGQ8HroQJGfPTaZJWlhod6+hlVvbA4f8c4MuaKix3LPvUsUsPV/pea
        ds8RXq5N5weP3+NyablK8PEFII1JhX44B5TnyJbHRwzq+ysL3U18sl4o1cmxSgLrhzJS1h
        KpH1IB5ncjTgtkK24Z7+iOSLqZglJxVbU+KShCd0RQU+wsH4aaceoTbdfe5bFslFCDBH6r
        duFUg+AQSTTNP91XqVS4jINaL1u5t23rNXoYkx5unyJxkLpnCrkp65NoE94ebkSsw0DlJv
        EVAcX9m1VMBLmJfevJw1eagXKcvvGDypW/y5Bad9EVoNqLgGlbxJFyCRfRcbRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606228932;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ATsDejaPv8NkLKCC6exgYHw07pd1pomeYiGhekbJbps=;
        b=ijynnphaJ0wZgeTJmO/hGkJex2gibT/GnEg6E1wzp5gUH04iqAMgJQnpBSZAXg7TOkFQDH
        Es2jMLVNZHKySODg==
From:   "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] sh/irq: Add missing closing parentheses in
 arch_show_interrupts()
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201124130656.2741743-1-geert+renesas@glider.be>
References: <20201124130656.2741743-1-geert+renesas@glider.be>
MIME-Version: 1.0
Message-ID: <160622893109.11115.12932515800816767356.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     15b8d9372f27c47e17c91f6f16d359314cf11404
Gitweb:        https://git.kernel.org/tip/15b8d9372f27c47e17c91f6f16d359314cf=
11404
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Tue, 24 Nov 2020 14:06:56 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 24 Nov 2020 15:37:16 +01:00

sh/irq: Add missing closing parentheses in arch_show_interrupts()

    arch/sh/kernel/irq.c: In function =E2=80=98arch_show_interrupts=E2=80=99:
    arch/sh/kernel/irq.c:47:58: error: expected =E2=80=98)=E2=80=99 before =
=E2=80=98;=E2=80=99 token
       47 |   seq_printf(p, "%10u ", per_cpu(irq_stat.__nmi_count, j);
	  |                                                          ^

Fixes: fe3f1d5d7cd3062c ("sh: Get rid of nmi_count()")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201124130656.2741743-1-geert+renesas@glider=
.be

---
 arch/sh/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
index 5addcb2..ab5f790 100644
--- a/arch/sh/kernel/irq.c
+++ b/arch/sh/kernel/irq.c
@@ -44,7 +44,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
=20
 	seq_printf(p, "%*s: ", prec, "NMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(irq_stat.__nmi_count, j);
+		seq_printf(p, "%10u ", per_cpu(irq_stat.__nmi_count, j));
 	seq_printf(p, "  Non-maskable interrupts\n");
=20
 	seq_printf(p, "%*s: %10u\n", prec, "ERR", atomic_read(&irq_err_count));
