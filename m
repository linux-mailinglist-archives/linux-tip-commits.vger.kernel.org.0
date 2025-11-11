Return-Path: <linux-tip-commits+bounces-7315-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F5BC4FD94
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 22:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7418D3BBA5F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 21:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51319368276;
	Tue, 11 Nov 2025 21:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iS1WI1un";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uc2j6XEe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485C535C1A3;
	Tue, 11 Nov 2025 21:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896200; cv=none; b=L6S2AfswtX8YsMqWarl2ay9TiATa3SS70JaHn7ZT2W2Z+sPOjD55iND6zU2aLS7wIuxVIebjy8d1uR8Rs4Bi3Trr203bvPCHj+ivKGX9IzNjt9o/nJvRawPaP0MTf8CmqYXlbv44Xt646JDYuvmtMbzNbGKLDn5onYMvaGSdeyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896200; c=relaxed/simple;
	bh=1u8yF+E6RuFheFf1irVMD2FQ1Uz50f5xYcRx3kuZ5Fo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IaJCR3DvrJfUQnGNvn03eLBN6c3hU4aRUL75FalZ64UCTLrCi/3SrmIHLTLfyP7sumxA6vq2D/4PudKsCIAHSpbM/2azZvN9Ylk1tJO85PYKL9FEp0Yb69UEpRSRvE9e6pSRPYRnw5oHVbIk+QboXC8CPJI7282UgOMf1idlMiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iS1WI1un; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uc2j6XEe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 21:23:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762896196;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5gRo+AUgnCFP9LDREHG5imF7ZQaP0/rayrIGgzV9QVk=;
	b=iS1WI1unRnCt8G2keeGOoFGoQzZUEfNDewMShXgOAz+NFnqmg2E0tVy2y7/8dTGmFI7f5j
	j0vFiQe/cmTOQHGk1vsaOHsMo3omf7bB8KUqguk5Hh4TFwQHVqmdudjJBSVDSLT/MKNh1F
	KgFF6fh2TgBYTbgDocBIlu+Nn0LBjtLimF0M28k0dRzMMJNl6dw/01ixIRrYJfkhEIDEYv
	IUPYT5qA0HasjqGXaZvN0KDoU3DNdgiKvCOQM0nUxCEw4fyRR0hJWKvQ2XjeTVpSvsPgFG
	/SrWQcuuyqHclu3UFyWSelchM0BDCMkmrBiq1oNUEOCke//R/1RS3TYWfjewVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762896196;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5gRo+AUgnCFP9LDREHG5imF7ZQaP0/rayrIGgzV9QVk=;
	b=uc2j6XEeYFdgnkgoPkciU2bPKMw2lO1ixeYnb6blqYlfo2xa2wtpWj3dCbOElhPeyijjYt
	BUgjQ6Y0NI7lQCDw==
From: "tip-bot2 for Junhui Liu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] dt-bindings: interrupt-controller: Add Anlogic
 DR1V90 ACLINT MSWI
Cc: Junhui Liu <junhui.liu@pigmoral.tech>,
 Thomas Gleixner <tglx@linutronix.de>, "Rob Herring (Arm)" <robh@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251021-dr1v90-basic-dt-v3-5-5478db4f664a@pigmoral.tech>
References: <20251021-dr1v90-basic-dt-v3-5-5478db4f664a@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176289619547.498.16836127845328612168.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     579951da64253e9592d21e54b1535e0119df78ab
Gitweb:        https://git.kernel.org/tip/579951da64253e9592d21e54b1535e0119d=
f78ab
Author:        Junhui Liu <junhui.liu@pigmoral.tech>
AuthorDate:    Tue, 21 Oct 2025 17:41:40 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 11 Nov 2025 22:17:21 +01:00

dt-bindings: interrupt-controller: Add Anlogic DR1V90 ACLINT MSWI

Add MSWI support for Anlogic DR1V90 SoC, which uses Nuclei UX900 with a
TIMER unit compliant with the ACLINT specification.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://patch.msgid.link/20251021-dr1v90-basic-dt-v3-5-5478db4f664a@pig=
moral.tech
---
 Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-msw=
i.yaml | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/thead,c90=
0-aclint-mswi.yaml b/Documentation/devicetree/bindings/interrupt-controller/t=
head,c900-aclint-mswi.yaml
index d6fb08a..62fd220 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclin=
t-mswi.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclin=
t-mswi.yaml
@@ -4,18 +4,23 @@
 $id: http://devicetree.org/schemas/interrupt-controller/thead,c900-aclint-ms=
wi.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
-title: Sophgo sg2042 CLINT Machine-level Software Interrupt Device
+title: ACLINT Machine-level Software Interrupt Device
=20
 maintainers:
   - Inochi Amaoto <inochiama@outlook.com>
=20
 properties:
   compatible:
-    items:
-      - enum:
-          - sophgo,sg2042-aclint-mswi
-          - sophgo,sg2044-aclint-mswi
-      - const: thead,c900-aclint-mswi
+    oneOf:
+      - items:
+          - enum:
+              - sophgo,sg2042-aclint-mswi
+              - sophgo,sg2044-aclint-mswi
+          - const: thead,c900-aclint-mswi
+      - items:
+          - enum:
+              - anlogic,dr1v90-aclint-mswi
+          - const: nuclei,ux900-aclint-mswi
=20
   reg:
     maxItems: 1

