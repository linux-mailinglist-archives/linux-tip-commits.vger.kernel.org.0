Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA6A2ADD52
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Nov 2020 18:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgKJRrd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Nov 2020 12:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgKJRrd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Nov 2020 12:47:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6368BC0613CF;
        Tue, 10 Nov 2020 09:47:33 -0800 (PST)
Date:   Tue, 10 Nov 2020 17:47:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605030450;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mEAqCmkLjY+QN2F9+QtcffwNijSbKSBgR51ZN03lPQQ=;
        b=KbmxabAch52Ghl23Df6nK4RaMnaXUv+9JmZLvOY0Dho7qZE3QY2EPW9rFwoqZrviMzWZ8O
        63rUglJ3YXJCLYDA0KqGpLDyqMvTXShA1XKQjhCnv+J3ZmvqIG1GjIwn+KN2rGiD+8P862
        FQH82z05h8W6lYyVpWawX0Gd8CjOaKPJCHEDhffWoQKz8dfK0ffpk6/7ngQ084e2qWoh6B
        OXO3hq5KLcy8VUA35DRs7/uH70VcqvDKhY0hE+inVKU4GNDCVlIGAf/07DUdxV4Hr2kH0T
        67dxm7MnYvuwl+9Srw6+1pAEegKt/jc9Uqiu5iemfTxo1VwW4TyEUmbdYbktMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605030450;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mEAqCmkLjY+QN2F9+QtcffwNijSbKSBgR51ZN03lPQQ=;
        b=cv/u9f/8eFjKeW4lJ1xj3DraXXzwotjEhRhlfn28NhZm7JfmmOSC7xKSSaf5juW2L8S6y6
        EvqKW4LZ49DoEYBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/ioapic: Correct the PCI/ISA trigger type selection
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>, Qian Cai <cai@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87d00lgu13.fsf@nanos.tec.linutronix.de>
References: <87d00lgu13.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <160503044953.11244.10545793402097139581.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     aec8da04e4d71afdd4ab3025ea34a6517435f363
Gitweb:        https://git.kernel.org/tip/aec8da04e4d71afdd4ab3025ea34a6517435f363
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 10 Nov 2020 15:34:32 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Nov 2020 18:43:22 +01:00

x86/ioapic: Correct the PCI/ISA trigger type selection

PCI's default trigger type is level and ISA's is edge. The recent
refactoring made it the other way round, which went unnoticed as it seems
only to cause havoc on some AMD systems.

Make the comment and code do the right thing again.

Fixes: a27dca645d2c ("x86/io_apic: Cleanup trigger/polarity helpers")
Reported-by: Tom Lendacky <thomas.lendacky@amd.com>
Reported-by: Borislav Petkov <bp@alien8.de>
Reported-by: Qian Cai <cai@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Link: https://lore.kernel.org/r/87d00lgu13.fsf@nanos.tec.linutronix.de
---
 arch/x86/kernel/apic/io_apic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 0602c95..089e755 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -809,9 +809,9 @@ static bool irq_is_level(int idx)
 	case MP_IRQTRIG_DEFAULT:
 		/*
 		 * Conforms to spec, ie. bus-type dependent trigger
-		 * mode. PCI defaults to egde, ISA to level.
+		 * mode. PCI defaults to level, ISA to edge.
 		 */
-		level = test_bit(bus, mp_bus_not_pci);
+		level = !test_bit(bus, mp_bus_not_pci);
 		/* Take EISA into account */
 		return eisa_irq_is_level(idx, bus, level);
 	case MP_IRQTRIG_EDGE:
