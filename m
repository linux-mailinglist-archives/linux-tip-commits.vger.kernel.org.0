Return-Path: <linux-tip-commits+bounces-8115-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPfODz6Ld2m9hgEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8115-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Jan 2026 16:41:50 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9778A422
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Jan 2026 16:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57EF33017042
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Jan 2026 15:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7170533E373;
	Mon, 26 Jan 2026 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GzbSmPx5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uAVCimgt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091B733A716;
	Mon, 26 Jan 2026 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769442078; cv=none; b=WQ/Vcdircr64JY+oV8s6Rs8eE7Fs09FZWaZ+PZnP2p/5DOsP6nTciMdVErjypsWQylIfXp5UlPEBREoSI1ghdTcn/botCk3aJfuduyM8ejQGPy6vPS+YakzNBzCydzL4QYTwNpOo/g1wwdN/tf/LXEkDTX1NrBuvPtGww39K1HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769442078; c=relaxed/simple;
	bh=uECqVvmpjinwkKyhcBi6gJ8rYjdPs8DPW2LhvLzqHPA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Z8u40mAxZ7aAuHp0qSrPioJik2hRFsicBQilHg3y/kRDhZDdaH67BSj0BkUUtZJx4E6icNlqWcjdmTASzN5SthL1a4Bl0MxlTXO+vPOIn7YE0eomPUhBh8QSefpfxuUSrfpdDQZ1lGBgj4zJgksumZ/D0W5Pfl0s7TSjzdgtg0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GzbSmPx5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uAVCimgt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Jan 2026 15:41:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769442074;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RvolQ4mCPzjFPSW5UEopdgb3v0ZTxxfScPGvBHjHZHE=;
	b=GzbSmPx5uSy1HeFisM4SARs5MCkZPPZqx8QWlUT841TEA2InFowey1bj8TZDP+HjXsGIpe
	Yy5cbVnRikSdut5axqU7AY82os/hmmuaLNblVLMo/sxHQ/H/iAPcEP0ZsBYwz88EqMsVGI
	g6PsHN0/3HJg4pWZ7MjrBS8oHc8Xd2sDpvv6Pd4KFRmpK2XZbIPYrP2Y9oEO7Thk4KgcPd
	bvD4OVhPJSEhSxX0faP7igORjQFEBxkEKghttiaItJIlqQ5jc4cOxaIwVVRJbAn4BqtSlA
	Dxfnzh73P9sT1TcAj4ypUB01+80a6XXY65KFWq9DO5wyRy4V1W2bhBCGGxqaSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769442074;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RvolQ4mCPzjFPSW5UEopdgb3v0ZTxxfScPGvBHjHZHE=;
	b=uAVCimgtaOWe4+SecVB+kqP3qfVii3u6vop2ZoinWkHI7gkH3oMxXyAwwAFEPrrAiSPAd0
	18LQzcA4a0tbFtCg==
From: "tip-bot2 for Aniket Limaye" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] dt-bindings: interrupt-controller: ti,sci-intr:
 Per-line interrupt-types
Cc: Aniket Limaye <a-limaye@ti.com>, Thomas Gleixner <tglx@kernel.org>,
 "Rob Herring (Arm)" <robh@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260123-ul-driver-i2c-j722s-v4-1-b08625c487d5@ti.com>
References: <20260123-ul-driver-i2c-j722s-v4-1-b08625c487d5@ti.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176944207369.510.9607619137690283844.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8115-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:replyto];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: DC9778A422
X-Rspamd-Action: no action

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     7a30a7a6c81e8343e27056ac0bddd5fcbc33b8a8
Gitweb:        https://git.kernel.org/tip/7a30a7a6c81e8343e27056ac0bddd5fcbc3=
3b8a8
Author:        Aniket Limaye <a-limaye@ti.com>
AuthorDate:    Fri, 23 Jan 2026 12:25:45 +05:30
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 26 Jan 2026 16:40:03 +01:00

dt-bindings: interrupt-controller: ti,sci-intr: Per-line interrupt-types

Update the bindings to allow setting per-line interrupt-types.

Some Interrupt Router instances can only work with a specific trigger
type (edge or level), while others act as simple passthroughs that
preserve the source interrupt type unchanged.

Make "ti,intr-trigger-type" property optional, with its absence
indicating that the router acts as a passthrough. When absent,
"#interrupt-cells" must be 2 to allow each interrupt source to specify
its trigger type per-line.

Signed-off-by: Aniket Limaye <a-limaye@ti.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://patch.msgid.link/20260123-ul-driver-i2c-j722s-v4-1-b08625c487d5=
@ti.com
---
 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml | 38=
 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-in=
tr.yaml b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.=
yaml
index c99cc73..de45f0c 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml
@@ -15,8 +15,7 @@ allOf:
 description: |
   The Interrupt Router (INTR) module provides a mechanism to mux M
   interrupt inputs to N interrupt outputs, where all M inputs are selectable
-  to be driven per N output. An Interrupt Router can either handle edge
-  triggered or level triggered interrupts and that is fixed in hardware.
+  to be driven per N output.
=20
                                    Interrupt Router
                                +----------------------+
@@ -64,9 +63,14 @@ properties:
   interrupt-controller: true
=20
   '#interrupt-cells':
-    const: 1
+    enum: [1, 2]
     description: |
-      The 1st cell should contain interrupt router input hw number.
+      Number of cells in interrupt specifier. Depends on ti,intr-trigger-typ=
e:
+      - If ti,intr-trigger-type is present: must be 1
+        The 1st cell should contain interrupt router input hw number.
+      - If ti,intr-trigger-type is absent: must be 2
+        The 1st cell should contain interrupt router input hw number.
+        The 2nd cell should contain interrupt trigger type (preserved by rou=
ter).
=20
   ti,interrupt-ranges:
     $ref: /schemas/types.yaml#/definitions/uint32-matrix
@@ -82,9 +86,22 @@ properties:
         - description: |
             "limit" specifies the limit for translation
=20
+if:
+  required:
+    - ti,intr-trigger-type
+then:
+  properties:
+    '#interrupt-cells':
+      const: 1
+      description: Interrupt ID only. Interrupt type is specified globally
+else:
+  properties:
+    '#interrupt-cells':
+      const: 2
+      description: Interrupt ID and corresponding interrupt type
+
 required:
   - compatible
-  - ti,intr-trigger-type
   - interrupt-controller
   - '#interrupt-cells'
   - ti,sci
@@ -105,3 +122,14 @@ examples:
         ti,sci-dev-id =3D <131>;
         ti,interrupt-ranges =3D <0 360 32>;
     };
+
+  - |
+    interrupt-controller {
+        compatible =3D "ti,sci-intr";
+        interrupt-controller;
+        interrupt-parent =3D <&gic500>;
+        #interrupt-cells =3D <2>;
+        ti,sci =3D <&dmsc>;
+        ti,sci-dev-id =3D <131>;
+        ti,interrupt-ranges =3D <0 360 32>;
+    };

