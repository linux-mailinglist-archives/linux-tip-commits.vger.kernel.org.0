Return-Path: <linux-tip-commits+bounces-3362-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71847A36D62
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Feb 2025 11:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286E218951AC
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Feb 2025 10:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80ED19D8AC;
	Sat, 15 Feb 2025 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xpfimjAX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H69qkZuX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08FF4A08;
	Sat, 15 Feb 2025 10:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739616941; cv=none; b=XgjvXBD+gDyJndVv8Opjb5NArONk3D4I2IPB7FCfwocxrh2dXacZzLuXI49DRDK0bbWWnocluL46C5M1O311p6flLAEfCnrMlK91s4UQx8bk1p4IaXnqEOIgAMdzf/pvyTRe78dYKzGcpfBxu3yO5YHoeNHNM4Ei4zqzFf8ZRIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739616941; c=relaxed/simple;
	bh=lsutgyfVwgCn3cJX4eKXD0Louo96A8EKR0pI+P69rEs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RamJ1XPZpQVn3eEbUMhvkv5iE1WrO8gnbBQZirAhDico11PqHnh+SeU4dmw7QxLwg2DmkTx0Gf+mY4v134vjYBo2EcY6nTeG/JCByY7ux+YFcEKUZMRlK2H/FasmjBA7V/E801msZuHEUG2m6VU985h70m6+TyzfxnB52kbtotg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xpfimjAX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H69qkZuX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 15 Feb 2025 10:55:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739616937;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnKHHa0zCQ4rdMiZJG1DUl92tOcflQzFHLDRX6rOi4Q=;
	b=xpfimjAXnDBSfYlsHezTXVGhLYdFbAPTRsBgNfhxFuAmmznQUDR4MGT7bMMhO57ncLs9Pq
	UPdO/eVt/U4e2fN/Ks9XqxSs8D28+QpYjYoj7kHIk8boczqILN5F4HepCRs/TDRVJ6TiNO
	yzerKj2oAjcmr0sZJvTSfkQj1WMzznVuddhPKm96Crb4glbdlwyOFVemN/P5Fq3NbsNE0i
	Q2G4xaG+uf5R7G6deTqoPwoLeEqC1dJHH8/l/qoz9OWTwtTE/V3vDTdGAAtUJg/5H8pjf0
	iiMi/XNxPGrpWyKfmH5fD4pzMAjT7cRFleJ765B27+hbLCSOuIFE0k2wSFjavA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739616937;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnKHHa0zCQ4rdMiZJG1DUl92tOcflQzFHLDRX6rOi4Q=;
	b=H69qkZuXja8gm/xrL9XtfQ1aVIkd7QD2lw5PpswS7n1Kxu2ywqXmhWp199YsOHcr+otPO1
	pnUG8R+fb9Sd/wBw==
From: "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/events/amd/iommu: Increase IOMMU_NAME_SIZE
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250210193412.483233-1-andriy.shevchenko@linux.intel.com>
References: <20250210193412.483233-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173961692629.10177.5199148332316223161.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     1623ced247f7cb1b48a27cca6b0f17fe5ab5942b
Gitweb:        https://git.kernel.org/tip/1623ced247f7cb1b48a27cca6b0f17fe5ab=
5942b
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Mon, 10 Feb 2025 21:34:12 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Feb 2025 10:32:02 +01:00

x86/events/amd/iommu: Increase IOMMU_NAME_SIZE

The init_one_iommu() takes an unsigned int argument that can't be checked for
the boundaries at compile time and GCC complains about that when build with
`make W=3D1`:

arch/x86/events/amd/iommu.c:441:53: note: directive argument in the range [0,=
 4294967294]
arch/x86/events/amd/iommu.c:441:9: note: =E2=80=98snprintf=E2=80=99 output be=
tween 12 and 21 bytes into a destination of size 16

Increase the size to cover all possible cases.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250210193412.483233-1-andriy.shevchenko@lin=
ux.intel.com
---
 arch/x86/events/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index b15f7b9..f8228d8 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -30,7 +30,7 @@
 #define GET_DOMID_MASK(x)  (((x)->conf1 >> 16) & 0xFFFFULL)
 #define GET_PASID_MASK(x)  (((x)->conf1 >> 32) & 0xFFFFFULL)
=20
-#define IOMMU_NAME_SIZE 16
+#define IOMMU_NAME_SIZE 24
=20
 struct perf_amd_iommu {
 	struct list_head list;

