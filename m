Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C03429EB6E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgJ2MPk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:15:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33262 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgJ2MPj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:39 -0400
Date:   Thu, 29 Oct 2020 12:15:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973737;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b9xm2E0cUjgRwhjWPPsX9aFyqp9s7l5FdlfubwBns6E=;
        b=ygcP8LDWUoEAJcy6RCJ+VLtImR4fSvXtkhmuw29AMrXeIRUpomqjixTlkVO+8p9i9qxUMT
        DrRGhUTm4UTcZJM/bjsr+cBeGYFYqwDw7ZRbHIEMmlR7I/b8R1nsZBv5LYhcK1uCpmU7RE
        qb3DbgHop8b57BtYUr7uywndP9dhS8lSPqTtXX+bH93u3ThMs9dI24T0HcDgheBIHofS5r
        QL89+I8EQN006AZvrbiRjmMcNe0bGrvQu7QhizGPPMlxNJiGnitke49aqCzh8+Onuckwv0
        3tf/dAq/V0prE1kuSWo186pyBpe29Y6iq33I4n7nLoEG4kou+Icuf6vkqRKBwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973737;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b9xm2E0cUjgRwhjWPPsX9aFyqp9s7l5FdlfubwBns6E=;
        b=hV9Tp2UuFXxazYsK0fKQD8sHW1jzkqV5/lN1+dQ3glmNk1Lw1Jxr/P/FBu2S1ZyEgHFzko
        EG9ZSBD5uprODGBQ==
From:   "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] genirq/irqdomain: Implement get_name() method on
 irqchip fwnodes
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201024213535.443185-23-dwmw2@infradead.org>
References: <20201024213535.443185-23-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160397373633.397.14636382540246372870.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     2cbd5a45e5296b28d64224ffbbd33d427704ba1b
Gitweb:        https://git.kernel.org/tip/2cbd5a45e5296b28d64224ffbbd33d427704ba1b
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Sat, 24 Oct 2020 22:35:22 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 20:26:27 +01:00

genirq/irqdomain: Implement get_name() method on irqchip fwnodes

Prerequisite to make x86 more irqdomain compliant.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20201024213535.443185-23-dwmw2@infradead.org

---
 kernel/irq/irqdomain.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index cf8b374..673fa64 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -42,7 +42,16 @@ static inline void debugfs_add_domain_dir(struct irq_domain *d) { }
 static inline void debugfs_remove_domain_dir(struct irq_domain *d) { }
 #endif
 
-const struct fwnode_operations irqchip_fwnode_ops;
+static const char *irqchip_fwnode_get_name(const struct fwnode_handle *fwnode)
+{
+	struct irqchip_fwid *fwid = container_of(fwnode, struct irqchip_fwid, fwnode);
+
+	return fwid->name;
+}
+
+const struct fwnode_operations irqchip_fwnode_ops = {
+	.get_name = irqchip_fwnode_get_name,
+};
 EXPORT_SYMBOL_GPL(irqchip_fwnode_ops);
 
 /**
