Return-Path: <linux-tip-commits+bounces-3327-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C26DA25B12
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 14:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65A7918889E4
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 13:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D0D20551E;
	Mon,  3 Feb 2025 13:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tbN9Hmii";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RRIgPV90"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46786205514;
	Mon,  3 Feb 2025 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738589826; cv=none; b=X1oLpZQzlA9Cna3Js5TnBSNZ2Xa9aWWxZHzsJ3BGVCwKzO0zvgY4d+8GL0EyZAYQtGI6eh60Moq/Z3mR6ow3NOQnm0fe9vQFFRLZ9tSJ5F0SkMUji5j9fj+zXPI2lCZ31AiqZ1xFueAmS8GcFuDYduXWNNI+KhlJ9js5Sg9KR18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738589826; c=relaxed/simple;
	bh=MTLM4f9YtvC6nDv63iX2+ecgDi8goTJAUi0K4RLoaj4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OI5qgVf8swTaK5lZ753JArxkSvD7tH2WnsdVcEfxDLUtXTfXPy4/LXVqCOM3E6xglqWDjkcgDX4z+p59bwV28FbnzrxCUsikog+b+S/NKr4kP73U8vqDkJOxGQZ23D48f0+Huq+NjzSZIIcxzhhwYZqmZaKS1oXlI3a6OZfqaWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tbN9Hmii; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RRIgPV90; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Feb 2025 13:37:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738589823;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y7salt+I32LV8ljZgO7WvZtoTGOTOli4uDDS8k/tnM4=;
	b=tbN9HmiiJnyFsFZrG0VWTKTL/Hirq4D2nM0nmD1/AuJBPWG8Bhu3X8t7a6WyriM7e5d390
	k/pjJwtCjpMSPl9fy2DzY26uPi/vWHY5ZV4f93IZvMMurUBTi2K5oSNSD+pqbibWybiLUz
	v3McK7zAHzky7XGpQjg/MeFujkllP04Uaq3+vjQv1iin0BjtJXBJgVRLehgSkck2il29Hk
	aGrvXJhYDhQL7AnHJuTFZN1X30Oy22bqFFy8FvQNknl9fgE0ArbMKLANqOzLWuGzM3pU0p
	trlWjW86Y0D7YkwM3enk6kWZV36DxgmmOSAFsn+ZV23nggL5xrvANGayO0+hkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738589823;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y7salt+I32LV8ljZgO7WvZtoTGOTOli4uDDS8k/tnM4=;
	b=RRIgPV90xoy6ld0CSsSgNaqmt5pxjyAhhlnU2uX0fXrp/ljZUH0F/eOWR2pLMq8auaokXL
	YwCtblSyg7UFonAg==
From: "tip-bot2 for Vladimir Kondratiev" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] dt-bindings: interrupt-controller: Add risc-v,aplic
 hart indexes
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <anup@brainfault.org>,
 "Rob Herring (Arm)" <robh@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250129091637.1667279-2-vladimir.kondratiev@mobileye.com>
References: <20250129091637.1667279-2-vladimir.kondratiev@mobileye.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173858982286.10177.15497324205236037235.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     c057b6e4213519e3ac167318238cd772b483f14a
Gitweb:        https://git.kernel.org/tip/c057b6e4213519e3ac167318238cd772b48=
3f14a
Author:        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
AuthorDate:    Wed, 29 Jan 2025 11:16:36 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Feb 2025 14:27:39 +01:00

dt-bindings: interrupt-controller: Add risc-v,aplic hart indexes

Document optional property "riscv,hart-indexes"

The RISC-V APLIC specification defines "hart index" in:

  https://github.com/riscv/riscv-aia

Within a given interrupt domain, each of the domain=E2=80=99s harts has a uni=
que
index number in the range 0 to 2^14 =E2=88=92 1 (=3D 16,383). The index numbe=
r a
domain associates with a hart may or may not have any relationship to the
unique hart identifier (=E2=80=9Chart ID=E2=80=9D) that the RISC-V Privileged=
 Architecture
assigns to the hart. Two different interrupt domains may employ entirely
different index numbers for the same set of harts.

Further, this document says in "4.5 Memory-mapped control region for an
interrupt domain":

The array of IDC structures may include some for potential hart index
numbers that are not actual hart index numbers in the domain. For example,
the first IDC structure is always for hart index 0, but 0 is not
necessarily a valid index number for any hart in the domain.

Support arbitrary hart indexes specified in a optional APLIC property
"riscv,hart-indexes" which is specificed as an array of u32 elements, one
per interrupt target. If this property is not specified, fallback to use
the logical hart indices within the domain.

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/all/20250129091637.1667279-2-vladimir.kondratie=
v@mobileye.com
---
 Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml | 8 =
++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,apl=
ic.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.=
yaml
index 190a649..bef0052 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
@@ -91,6 +91,14 @@ properties:
       Firmware must configure interrupt delegation registers based on
       interrupt delegation list.
=20
+  riscv,hart-indexes:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 16384
+    description:
+      A list of hart indexes that APLIC should use to address each hart
+      that is mentioned in the "interrupts-extended"
+
 dependencies:
   riscv,delegation: [ "riscv,children" ]
=20

