Return-Path: <linux-tip-commits+bounces-8198-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AitAIcdg2nehwMAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8198-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Feb 2026 11:20:55 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F8DE4657
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Feb 2026 11:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ACC453000B92
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Feb 2026 10:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450453D3D06;
	Wed,  4 Feb 2026 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LN3IX7WT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s+plRuLU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94933D412E;
	Wed,  4 Feb 2026 10:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770200450; cv=none; b=sMNoDtHlJFNUFILLiZDPzUCCenZSwL7bxPOsY4PWUZtNx+EWaIL/QTlfMQSGcSzC3eOsususHYoqqdisxscmhkZjm2dwy2Yj1Ry9qRBqKU6DiBYrZTI7SolIYTwXLMXGPdlAoGOujjMoWS+5kCtfAqxrymvjyW4Ym3ECwEgVts8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770200450; c=relaxed/simple;
	bh=I06696zq2Yh55JLChck134cxivi/wGS1uJowHvU5V6Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TQbRHPB38KHGHrYxoSz8zioNVpWY5BWMCOotfYg9bIV4voKNon0mBPX/fqNj7YKqHsQxUm0usNMkM5IALG4IPwihtTaeze5uMOq4dqkvBfkorejA5tAt+89DU8farRbJ4kYtGA+EzDFgVHk3UEn3fIEgzNqmZy1SPRW5YQTUCLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LN3IX7WT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s+plRuLU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Feb 2026 10:20:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770200448;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EIxJ4p2UNRO/kKqc+c+NrJdpQTtF9mTMGvmsXdKi/uA=;
	b=LN3IX7WTX/7wXmhjMs7+rEG7KcwEvDniJRnoqMwJ6RzsDq2QCWenVtxhbeomORxxQGKWtI
	lbbz/PRLPCZCVNi1a/1O1t7GqaHjd3eqOVHdGUg3gzLOWDVJCMUYfnCGogDVzG8Wa4ayjB
	NIS6HfzZjvJGWIGdmdMzjGHjebSWSv6wJlualj9HOe865ZNgW+f/8T4YgX4QHn8lkynLCU
	tYKGaF1rnBoQyxHIZdffzSmxdCeyvYPMnFBcsNFdX6k8AeFb7SznjqMPKVUwjExkZGpDcy
	rEi4vN7Dr00W3t5Q2py0MHrDMfzU8w4B3sQMb1HvBKmTCHFStdJO8erqnWjhFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770200448;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EIxJ4p2UNRO/kKqc+c+NrJdpQTtF9mTMGvmsXdKi/uA=;
	b=s+plRuLUK7UuDU2u3FPUI0jBc712IlblXnB64TWRUkhSE2MyZXMyG790MPxYzIlvMyuoCB
	cKZDOLf8zYvduzDA==
From: "tip-bot2 for Yangyu Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] dt-bindings: interrupt-controller: sifive,plic:
 Clarify the riscv,ndev meaning in PLIC
Cc: Yangyu Chen <cyy@cyyself.name>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <tencent_720A4669773B1EE15EC720869C35C2F0490A@qq.com>
References: <tencent_720A4669773B1EE15EC720869C35C2F0490A@qq.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177020044678.2495410.7909430195430121858.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8198-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:replyto,linutronix.de:dkim,cyyself.name:email];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 23F8DE4657
X-Rspamd-Action: no action

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     889588d750506d86ba16ae3b968b5ffc5937d5f8
Gitweb:        https://git.kernel.org/tip/889588d750506d86ba16ae3b968b5ffc593=
7d5f8
Author:        Yangyu Chen <cyy@cyyself.name>
AuthorDate:    Wed, 04 Feb 2026 01:21:48 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Wed, 04 Feb 2026 11:13:58 +01:00

dt-bindings: interrupt-controller: sifive,plic: Clarify the riscv,ndev meanin=
g in PLIC

In PLIC, interrupt source 0 is reserved and should not be used.
Therefore, the valid interrupt sources are from 1 to riscv,ndev
inclusive.

Update the documentation to clarify this point.

[ tglx: Fixup subject prefix ]

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/tencent_720A4669773B1EE15EC720869C35C2F0490A@q=
q.com
---
 Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yam=
l | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,pl=
ic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive=
,plic-1.0.0.yaml
index 388fc2c..e026722 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.=
0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.=
0.yaml
@@ -108,7 +108,9 @@ properties:
   riscv,ndev:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-      Specifies how many external interrupts are supported by this controlle=
r.
+      Specifies how many external (device) interrupts are supported by this
+      controller.  Note that source 0 is reserved in PLIC, so the valid
+      interrupt sources are 1 to riscv,ndev inclusive.
=20
   clocks: true
=20

