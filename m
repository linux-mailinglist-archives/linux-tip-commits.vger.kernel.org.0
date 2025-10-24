Return-Path: <linux-tip-commits+bounces-6993-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F141C07EEC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Oct 2025 21:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0711AA4D30
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Oct 2025 19:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56872C08C0;
	Fri, 24 Oct 2025 19:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TRs7cOeQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mw8YzDsM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088B82C0275;
	Fri, 24 Oct 2025 19:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761334774; cv=none; b=EL4ovXT4Gckpb8p6jFH/aucUduyUqFM5f0RKO/3ek7ob3VxorNDKFSCHN5Cib8lGtX3fybw+tQbFnz9fCUEL+igRN2Cib8d4GWLw3fltfkEnoAdcO4KbqvvBr8WFjBvcHpJmGFvkfVTcq32BBtVtJLLclfMsL/sx3xS6UCUFge4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761334774; c=relaxed/simple;
	bh=vEE1O4xCXEd6BLN4jEDpBd1upBOiOpTvUENucek+XNE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GdcdPqtBx3ysNfPYSJoGPKMLCoLIlQ58os6M0YGMiBovRuZzijfIiLnPmgIQZr/nytnORiAIX+DDvXqlsUD2cedhiX9b1Y/OSlvnsmROIwRTOVmubSgQNHKcs7FxyOMNcCWZjCaRN/Q1L9o/ZrA/7upx95pywV97ijxj4LIUHMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TRs7cOeQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mw8YzDsM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 24 Oct 2025 19:39:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761334771;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5g7IrKWstGUZk0s08YoQ27IHHBCXxhMqknnVGfPaiCc=;
	b=TRs7cOeQZdPqyB7UUf8jU7Glms8fdt2CeKjVoJX/0j4jJJu1Wi84+3NsZadd/RUI3nBuPm
	jQ9MQl1slrTGgKmoAfb8fur2RSDXjHI8GcwMjWls4i71w/kdMvP7eTi99zGCyoN408rAF6
	7NdDPBY4OuilTqPj6+Y/Q94xMpJocvBE6GMfrZjtZDE9sP9HlkmzFQMlWOtCf03Diuw8BU
	FzJzHvjyQvCbkSuD8/2GC40RuznW+iPbjyuI/L71WKkqfK4r6/2OF14uJy4EiiiLmruwxt
	FFd/xGH8GIjd1+a/Jb+kZpdxOPB4WyLHz0iGcmWr8nlZGNfLc3Kf3tTmzhPCAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761334771;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5g7IrKWstGUZk0s08YoQ27IHHBCXxhMqknnVGfPaiCc=;
	b=Mw8YzDsMezX4WmeuUPJJpPYpate6z96Cj5X1Elh8S/BxCcYkHd4BLcten/T1zsoHfaWi+Q
	Ih/cfDKP7vMLxsBA==
From: "tip-bot2 for Charles Mirabile" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] dt-bindings: interrupt-controller: Add UltraRISC
 DP1000 PLIC
Cc: Charles Mirabile <cmirabil@redhat.com>,
 Lucas Zampieri <lzampier@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Conor Dooley <conor.dooley@microchip.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251024083647.475239-3-lzampier@redhat.com>
References: <20251024083647.475239-3-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176133477011.2601451.7954707236778148260.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     9dfb295a93eb109be989aac48f675db5b1c68bd8
Gitweb:        https://git.kernel.org/tip/9dfb295a93eb109be989aac48f675db5b1c=
68bd8
Author:        Charles Mirabile <cmirabil@redhat.com>
AuthorDate:    Fri, 24 Oct 2025 09:36:41 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Oct 2025 21:34:32 +02:00

dt-bindings: interrupt-controller: Add UltraRISC DP1000 PLIC

Add compatible strings for the PLIC found in UltraRISC DP1000 SoC.

The PLIC is part of the UR-CP100 core and has a hardware bug requiring
a workaround.

Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://patch.msgid.link/20251024083647.475239-3-lzampier@redhat.com
---
 Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yam=
l | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,pl=
ic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive=
,plic-1.0.0.yaml
index f683d69..234cdc2 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.=
0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.=
0.yaml
@@ -76,6 +76,9 @@ properties:
               - thead,th1520-plic
           - const: thead,c900-plic
       - items:
+          - const: ultrarisc,dp1000-plic
+          - const: ultrarisc,cp100-plic
+      - items:
           - const: sifive,plic-1.0.0
           - const: riscv,plic0
         deprecated: true

