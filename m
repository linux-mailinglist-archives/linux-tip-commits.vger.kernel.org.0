Return-Path: <linux-tip-commits+bounces-7316-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA2DC4FD97
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 22:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 199CE3BF18B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 21:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE55036828A;
	Tue, 11 Nov 2025 21:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G+bNbcs7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xgYMqB18"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2551935C1B4;
	Tue, 11 Nov 2025 21:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896200; cv=none; b=VUsInotR4A97qmSWHlGHWPlOtyNtDDYw/X0amQmEpS1NkekkDv1sonZyxr6vguAbQB9Ug1si4OIEySXK32Zm8uTrFlFRUJL8Hnze1kkq+dX9VIvCgmZgjTSrv8P7v5jRQwh/jG1HDe0n/FQsZ4kSGZfO0XUcqNSBdLe9jbqurjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896200; c=relaxed/simple;
	bh=zrntGOlyBHhxBHA4p0exHz//deJs0AbIEtuu9NNcig8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=peamCIxTZggE6pel1hlUKlG8j9VaUEmY83ROHCiiQjPoP59JPtV3N+NcQBCJ87z7L1cnGZV6KQfHIx39hGtwVYFZ65B/FpsHIuPD8ML5KxnULCLtGn+/bspdSwapoJBNDcJOf/xspusfWSIXinbxJnNpuXDmd2UGGR1JQaVyxjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G+bNbcs7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xgYMqB18; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 21:23:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762896197;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6+fJKq7jX9Ghb1saXWlXicxrf+ptmR8d6HukYCfEP9c=;
	b=G+bNbcs7bNwGHog26W5Ha9hoMqmI6BAZKHLwDuIEkbaGHxiFAO08IZQte3koPSg1mKlDRL
	TzUUXTC47LfWWAMiNxKjqJV4ZgbwCwuuwY33eaEMCylkPpyZFw4Z7iqQi4DPU7VqAmyCLI
	zqf87hrn2kWEIUFuZ5xDz/Py2OR3ewWsVYJf6s6S6gzsJcXAQqffznWR3G2ZtHIp66ekwJ
	uk2kLqpOJ/+GN8FVTHNBsYz4DCzgzgJlC+HDGFoB5ock8AcXaKDJCvyOzuZRfb2sRv0Nbi
	NRNtiNpGFvjSTjnjkJtqvt51ksCUvkWSUwVd1Ug2d+oW4bJoWgy+b5GgovNq5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762896197;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6+fJKq7jX9Ghb1saXWlXicxrf+ptmR8d6HukYCfEP9c=;
	b=xgYMqB18SrtCPol7kHdk/N6zEIMojJdv/HuzRJ6GcgGV1xtV6Hme7egxINXhBr9lb8ZCpC
	Xz4T4DUMg2oyPICg==
From: "tip-bot2 for Junhui Liu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] dt-bindings: interrupt-controller: Add Anlogic DR1V90 PLIC
Cc: Junhui Liu <junhui.liu@pigmoral.tech>,
 Thomas Gleixner <tglx@linutronix.de>,
 Conor Dooley <conor.dooley@microchip.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251021-dr1v90-basic-dt-v3-4-5478db4f664a@pigmoral.tech>
References: <20251021-dr1v90-basic-dt-v3-4-5478db4f664a@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176289619645.498.15094597072168596459.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     b90ac5fe3285aa8bed625375d1df959c4c9a2cdb
Gitweb:        https://git.kernel.org/tip/b90ac5fe3285aa8bed625375d1df959c4c9=
a2cdb
Author:        Junhui Liu <junhui.liu@pigmoral.tech>
AuthorDate:    Tue, 21 Oct 2025 17:41:39 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 11 Nov 2025 22:17:21 +01:00

dt-bindings: interrupt-controller: Add Anlogic DR1V90 PLIC

Add PLIC support for Anlogic DR1V90.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://patch.msgid.link/20251021-dr1v90-basic-dt-v3-4-5478db4f664a@pig=
moral.tech
---
 Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yam=
l | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,pl=
ic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive=
,plic-1.0.0.yaml
index 234cdc2..6fdb7ae 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.=
0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.=
0.yaml
@@ -58,6 +58,7 @@ properties:
           - const: andestech,nceplic100
       - items:
           - enum:
+              - anlogic,dr1v90-plic
               - canaan,k210-plic
               - eswin,eic7700-plic
               - sifive,fu540-c000-plic

