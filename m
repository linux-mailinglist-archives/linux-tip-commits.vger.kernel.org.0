Return-Path: <linux-tip-commits+bounces-7314-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632D1C4FD8E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 22:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 359623BA78E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 21:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C7435C1B0;
	Tue, 11 Nov 2025 21:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VS6iKKKD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="32o69/D2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0C835C19B;
	Tue, 11 Nov 2025 21:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896198; cv=none; b=f5XoXFnqBGjiUyYau5ThsMZTr2tpMCQDFEDC4KF16LoYelrxIAJsYYgl3gNbYQVeEHxAxGp0mxCPQRvPJ/1pXjLimDHjmNOvYxDb8FUdX7czsBzC1HbA3FJI0dJqtu6cdD6JL1N1Wf9rqZDXJ/dOJMrDEkrGinJ6JSuITx5iTkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896198; c=relaxed/simple;
	bh=0hC/C496ivqMUKqPTDd+kVh2fn6iGRFZiSqghtEUGXY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hQ/OkPmnJsc352m2BDZ8E2D3r0/54DfPQrvKRvLOtz4Fcd+n4Ln+XiPPibVsgfFWtY4wN2lUgw+82em/QmEQzg4kHITWB1fmFK4EOCjlvIt3YID8E6I/IFr8b0qE5YBJaZ7frr82A1Ppgk7Gaeh2r+Cv5ZWUNPE7qx8wncuDNLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VS6iKKKD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=32o69/D2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 21:23:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762896195;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BnhfRnAHttdR+UF8DdRA+6fk+2I8wvhaTdQLpgXZN1A=;
	b=VS6iKKKDOf7PBfM/bPPR/FiH4Yk7tZmUxJtVmBfdM0gOylSsqrJK3NiHaH8NUDRHLsdff4
	+r1FNQkpFTN6ekaFSWFkRHWV5E9FVCgeb0Cypeqamuq7xH1HPZjYool0XYnprc2Of51jGo
	38BQ5pvb4/EwswhYEwIRRgoPRxIWAFH4kjyEAdVUx6xjY1Xen5y/y8tPmkuiaHu+u9nano
	33mvFHn8CnjnJSaWB1mad6fIZUaV17jJxu65jOjnU1bK7GW2BtPeNhTLsVHTyGKiNlA3Dt
	lxloWWVaWd3OP2z6Vb/f9JijdA60838ZgSIjjxf6eWK9Hei2Wn082PmJOe7aVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762896195;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BnhfRnAHttdR+UF8DdRA+6fk+2I8wvhaTdQLpgXZN1A=;
	b=32o69/D2QiqNMXoXPc6fUJ5SG/pnG9NXH4oTVjPHwcaBK7dklV17hF8Rug30r56kcrnGTY
	RwjFQRL3Vp1G3ZCQ==
From: "tip-bot2 for Junhui Liu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] dt-bindings: interrupt-controller: Add Anlogic
 DR1V90 ACLINT SSWI
Cc: Junhui Liu <junhui.liu@pigmoral.tech>,
 Thomas Gleixner <tglx@linutronix.de>, "Rob Herring (Arm)" <robh@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251021-dr1v90-basic-dt-v3-6-5478db4f664a@pigmoral.tech>
References: <20251021-dr1v90-basic-dt-v3-6-5478db4f664a@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176289619448.498.18416207491068515875.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     a1c3a7d7ee0291e6bbc89192cb942cbebadb31fe
Gitweb:        https://git.kernel.org/tip/a1c3a7d7ee0291e6bbc89192cb942cbebad=
b31fe
Author:        Junhui Liu <junhui.liu@pigmoral.tech>
AuthorDate:    Tue, 21 Oct 2025 17:41:41 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 11 Nov 2025 22:17:21 +01:00

dt-bindings: interrupt-controller: Add Anlogic DR1V90 ACLINT SSWI

Add SSWI support for Anlogic DR1V90 SoC, which uses Nuclei UX900 with a
TIMER unit compliant with the ACLINT specification.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://patch.msgid.link/20251021-dr1v90-basic-dt-v3-6-5478db4f664a@pig=
moral.tech
---
 Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-ssw=
i.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/thead,c90=
0-aclint-sswi.yaml b/Documentation/devicetree/bindings/interrupt-controller/t=
head,c900-aclint-sswi.yaml
index c1ab865..d02c688 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclin=
t-sswi.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclin=
t-sswi.yaml
@@ -30,6 +30,10 @@ properties:
           - const: thead,c900-aclint-sswi
       - items:
           - const: mips,p8700-aclint-sswi
+      - items:
+          - enum:
+              - anlogic,dr1v90-aclint-sswi
+          - const: nuclei,ux900-aclint-sswi
=20
   reg:
     maxItems: 1

