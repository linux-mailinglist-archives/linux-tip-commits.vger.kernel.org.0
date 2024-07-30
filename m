Return-Path: <linux-tip-commits+bounces-1889-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5E7942045
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 21:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 970C0B20AA4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 19:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680C4189B86;
	Tue, 30 Jul 2024 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rkho+DJd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9BlEr8oN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE951AA3C5;
	Tue, 30 Jul 2024 19:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722366294; cv=none; b=Y6aVdyzmx3YLXoUeE+jaOOWnzcA/OMNYI6knQQk/n/0QoqA0dca8LVtos9NQIr8Ohay1dHB3XDVtbheT1l0gLQSiPagu0AEYFrbHw/9WLVJUVR9SwchYGMRYthaNd4clxJLevJvhCeo5mhOhfpKj110Xc/qeI2H2pD21mXQz10Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722366294; c=relaxed/simple;
	bh=oVKeHFFoZFQMySEyOsdm7JlxCISNXZlQvfwA/php4Fc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VSLu7F1F9uMpkGt47rxuXaIHYhAPugNB9FhsuaonwyFfAhlLsNLeO0/D/x17qmqCWT/tNUtm9sFhtz1ipeOvKbDEiZTqB8VuiyA7GTvLgEuqyZSz/Z0U15d69hSXjL6dYhOA8VPF94yR/5BFBqRM5elPqiraHYehL7nRPAGRL+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rkho+DJd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9BlEr8oN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 19:04:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722366291;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IB8u/7RN+CGkeJfNsTbzqvqy++g6KzisT34Sq58yOwQ=;
	b=Rkho+DJdg3lxVda9qySR2h4jPqMuuO2lW5sscjW2S7kbOxjX4+ARcpuRImWbtVXqc/iSjr
	H4gjCi2uYOWxwGF29/gFyrZQDIUF13CvMUhqqTnbeSywSYWQ/ndxzFE9vU6hHiyaAiff0I
	7h7Kho0Fqifm0TUrGN2hcczIKeDTDoaF2R2MzFOSqLRaEHp3+5MLSCXuDhE/8WwLsp7W4e
	XNGThRBFVw401qrrpuQEqgDhUAeJBn2pjaPSHgA/qBSK1wp8CqQWurnNYRQJ+Y98jCKZO3
	v5FMB6vRmMW4CSLwDdjCqkYgcYhmVR9suBVs89+BjX7VyG2vQxkQWaWP93C1KA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722366291;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IB8u/7RN+CGkeJfNsTbzqvqy++g6KzisT34Sq58yOwQ=;
	b=9BlEr8oNF5X09JU+J9ct3oVthoZXbsDAxl31/F93ww6xKits6rtsLf/MwlQ0/1FBCKXMDZ
	S2fwsK/zHAOy6SDg==
From: "tip-bot2 for Yipeng Zou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/mbigen: Fix mbigen node address layout
Cc: Yipeng Zou <zouyipeng@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240730014400.1751530-1-zouyipeng@huawei.com>
References: <20240730014400.1751530-1-zouyipeng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172236629057.2215.379322676675427251.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     6be6cba9c4371d27f78d900ccfe34bb880d9ee20
Gitweb:        https://git.kernel.org/tip/6be6cba9c4371d27f78d900ccfe34bb880d9ee20
Author:        Yipeng Zou <zouyipeng@huawei.com>
AuthorDate:    Tue, 30 Jul 2024 09:44:00 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Jul 2024 20:59:12 +02:00

irqchip/mbigen: Fix mbigen node address layout

The mbigen interrupt chip has its per node registers located in a
contiguous region of page sized chunks. The code maps them into virtual
address space as a contiguous region and determines the address of a node
by using the node ID as index.

                    mbigen chip
       |-----------------|------------|--------------|
   mgn_node_0         mgn_node_1     ...         mgn_node_i
|--------------|   |--------------|       |----------------------|
[0x0000, 0x0x0FFF] [0x1000, 0x1FFF]    [i*0x1000, (i+1)*0x1000 - 1]

This works correctly up to 10 nodes, but then fails because the 11th's
array slot is used for the MGN_CLEAR registers.

                         mbigen chip
    |-----------|--------|--------|---------------|--------|
mgn_node_0  mgn_node_1  ...  mgn_clear_register  ...   mgn_node_i
                            |-----------------|
                             [0xA000, 0xAFFF]

Skip the MGN_CLEAR register space when calculating the offset for node IDs
greater than or equal to ten.

Fixes: a6c2f87b8820 ("irqchip/mbigen: Implement the mbigen irq chip operation functions")
Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240730014400.1751530-1-zouyipeng@huawei.com

---
 drivers/irqchip/irq-mbigen.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 093fd42..53cc083 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -64,6 +64,20 @@ struct mbigen_device {
 	void __iomem		*base;
 };
 
+static inline unsigned int get_mbigen_node_offset(unsigned int nid)
+{
+	unsigned int offset = nid * MBIGEN_NODE_OFFSET;
+
+	/*
+	 * To avoid touched clear register in unexpected way, we need to directly
+	 * skip clear register when access to more than 10 mbigen nodes.
+	 */
+	if (nid >= (REG_MBIGEN_CLEAR_OFFSET / MBIGEN_NODE_OFFSET))
+		offset += MBIGEN_NODE_OFFSET;
+
+	return offset;
+}
+
 static inline unsigned int get_mbigen_vec_reg(irq_hw_number_t hwirq)
 {
 	unsigned int nid, pin;
@@ -72,8 +86,7 @@ static inline unsigned int get_mbigen_vec_reg(irq_hw_number_t hwirq)
 	nid = hwirq / IRQS_PER_MBIGEN_NODE + 1;
 	pin = hwirq % IRQS_PER_MBIGEN_NODE;
 
-	return pin * 4 + nid * MBIGEN_NODE_OFFSET
-			+ REG_MBIGEN_VEC_OFFSET;
+	return pin * 4 + get_mbigen_node_offset(nid) + REG_MBIGEN_VEC_OFFSET;
 }
 
 static inline void get_mbigen_type_reg(irq_hw_number_t hwirq,
@@ -88,8 +101,7 @@ static inline void get_mbigen_type_reg(irq_hw_number_t hwirq,
 	*mask = 1 << (irq_ofst % 32);
 	ofst = irq_ofst / 32 * 4;
 
-	*addr = ofst + nid * MBIGEN_NODE_OFFSET
-		+ REG_MBIGEN_TYPE_OFFSET;
+	*addr = ofst + get_mbigen_node_offset(nid) + REG_MBIGEN_TYPE_OFFSET;
 }
 
 static inline void get_mbigen_clear_reg(irq_hw_number_t hwirq,

