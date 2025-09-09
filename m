Return-Path: <linux-tip-commits+bounces-6525-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE8FB4AA7D
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 12:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17A51677CB
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 10:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3D2309EEA;
	Tue,  9 Sep 2025 10:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uoUZ/8nd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b0fpJcdS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFF623770D;
	Tue,  9 Sep 2025 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413506; cv=none; b=mmK54FTrbMvzLdmjiFTfcTS4PRVqTlVZ43XZYqO7OSZcVe0rOeOnT2tnuTLw60w3YGhT+zAh62RxpPZdCMhKkdCnB7RhYv2KVp/h7SBP/6BS8d51oCas9w6Nwfm26Vz1pSX6weqDUw/lo3ybjbrFjm5ECgxs6Ya2S9apUzSUdZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413506; c=relaxed/simple;
	bh=SWPmqQ+s+HCiAAhdh+Ah9xV3KbwXe8/4awEXmGscD5M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lzq/bYBveQGjbZ869JUFs434od9TExCPwrEUYVeyHURf7yxHMgouwS8UNYZedAgzQT1xm92yIIY8OrJYdW0DjG/TZOHPHlR1/6+VWfVYztBI/eHIhCOpx4K7JcXH4kEKN4MNVbo7+vz9U7laiKDdmXUu0Jv+K9SbX3uFdolgZRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uoUZ/8nd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b0fpJcdS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 10:25:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757413502;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MTRVhC6V9Xl53lMiZKnhNTzTb01AzJYtx+6RcEGPHy4=;
	b=uoUZ/8nd2nVOAw6z9i8lTHBE63x44xL2olKFaaC3pWSksAzPLz5UlGJcSItU2Nz69XtidH
	/jau3sNk2IpFKpB3Y2uAztiWqT0KT0zhYjiFKflx2kmFp+pKaKzTfG9/H+gl8wqYnC17CN
	E0F70ny4h5Pbang9H7NJnPxdksjWl7TPM+VTr4Lqs3U5yeqCeCpLdZ0oKabhh1/LRRw7HN
	nL9WqkddrW940F9RZmeWyhy7VhYp1dkKW7hIGuphkwMwub3EBTEgFGDYi/+DDSFWeiAUOV
	l/Cb8J0EUVnivHaMuvmubHTU8dZlKqs6tNZKUQzcCEyWDrV5rlKj7SiBpPr80g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757413502;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MTRVhC6V9Xl53lMiZKnhNTzTb01AzJYtx+6RcEGPHy4=;
	b=b0fpJcdSXn6b1ennE4m/Pwtz7mzJQJzVMLrL0B+TmZoRFQ5Cl+6BQqoZQqDe8yXP6F1w0V
	ZwuXju2YtUQBylBQ==
From: "tip-bot2 for Ryan Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] dt-bindings: interrupt-controller: aspeed: Add
 AST2700 SCU IC compatibles
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Rob Herring (Arm)" <robh@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250908011812.1033858-4-ryan_chen@aspeedtech.com>
References: <20250908011812.1033858-4-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175741350149.1920.12916001167378232280.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     ed7240444e82aaaa2245a3cc9b040e4db894a665
Gitweb:        https://git.kernel.org/tip/ed7240444e82aaaa2245a3cc9b040e4db89=
4a665
Author:        Ryan Chen <ryan_chen@aspeedtech.com>
AuthorDate:    Mon, 08 Sep 2025 09:18:11 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 12:23:28 +02:00

dt-bindings: interrupt-controller: aspeed: Add AST2700 SCU IC compatibles

Add compatible strings for the four SCU interrupt controller instances
on the AST2700 SoC (scu-ic0 to 3), following the multi-instance model used
on AST2600.

Also define interrupt indices in the binding header.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/all/20250908011812.1033858-4-ryan_chen@aspeedte=
ch.com

---
 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2500-scu-ic=
.yaml |  6 +++++-
 include/dt-bindings/interrupt-controller/aspeed-scu-ic.h                    =
      | 14 ++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,as=
t2500-scu-ic.yaml b/Documentation/devicetree/bindings/interrupt-controller/as=
peed,ast2500-scu-ic.yaml
index d5287a2..d998a9d 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2500-s=
cu-ic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2500-s=
cu-ic.yaml
@@ -5,7 +5,7 @@
 $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2500-scu-i=
c.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
-title: Aspeed AST25XX and AST26XX SCU Interrupt Controller
+title: Aspeed AST25XX, AST26XX, AST27XX SCU Interrupt Controller
=20
 maintainers:
   - Eddie James <eajames@linux.ibm.com>
@@ -16,6 +16,10 @@ properties:
       - aspeed,ast2500-scu-ic
       - aspeed,ast2600-scu-ic0
       - aspeed,ast2600-scu-ic1
+      - aspeed,ast2700-scu-ic0
+      - aspeed,ast2700-scu-ic1
+      - aspeed,ast2700-scu-ic2
+      - aspeed,ast2700-scu-ic3
=20
   reg:
     maxItems: 1
diff --git a/include/dt-bindings/interrupt-controller/aspeed-scu-ic.h b/inclu=
de/dt-bindings/interrupt-controller/aspeed-scu-ic.h
index f315d5a..7dd0442 100644
--- a/include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
+++ b/include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
@@ -20,4 +20,18 @@
 #define ASPEED_AST2600_SCU_IC1_LPC_RESET_LO_TO_HI	0
 #define ASPEED_AST2600_SCU_IC1_LPC_RESET_HI_TO_LO	1
=20
+#define ASPEED_AST2700_SCU_IC0_PCIE_PERST_LO_TO_HI	3
+#define ASPEED_AST2700_SCU_IC0_PCIE_PERST_HI_TO_LO	2
+
+#define ASPEED_AST2700_SCU_IC1_PCIE_RCRST_LO_TO_HI	3
+#define ASPEED_AST2700_SCU_IC1_PCIE_RCRST_HI_TO_LO	2
+
+#define ASPEED_AST2700_SCU_IC2_PCIE_PERST_LO_TO_HI	3
+#define ASPEED_AST2700_SCU_IC2_PCIE_PERST_HI_TO_LO	2
+#define ASPEED_AST2700_SCU_IC2_LPC_RESET_LO_TO_HI	1
+#define ASPEED_AST2700_SCU_IC2_LPC_RESET_HI_TO_LO	0
+
+#define ASPEED_AST2700_SCU_IC3_LPC_RESET_LO_TO_HI	1
+#define ASPEED_AST2700_SCU_IC3_LPC_RESET_HI_TO_LO	0
+
 #endif /* _DT_BINDINGS_INTERRUPT_CONTROLLER_ASPEED_SCU_IC_H_ */

