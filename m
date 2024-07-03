Return-Path: <linux-tip-commits+bounces-1591-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B8492690B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Jul 2024 21:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC888282CFD
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Jul 2024 19:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946C8191F6D;
	Wed,  3 Jul 2024 19:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GvK7sq/Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uPEHmn7J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1238A18FC82;
	Wed,  3 Jul 2024 19:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720035383; cv=none; b=JIq7VBndrZ6CCc0ki5THhf2XOr8S/sFfoy/tt8H+6k1qGXtEhIFq1jbfGIy3P1Jb1dC5qk1isaM/3D94gXkHrckIJPpsum5ZfZy4hd3t4qRXiPAJYXcrutCx20Lf7znPKHSoPVVmwhk6uNYxlz7/GJW4gy6Oh3mu73XgmtrSgYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720035383; c=relaxed/simple;
	bh=90y2bcS2wt6LOFZBOv1kciP1RVRdUyB64WN/jKcezY8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j5z+Zmj8qntGcvKghH4BDkK44W/Tgsa8JxGOr7o2mVmmXDB2IOhEKaOAFhbABu6MH1av3ml7/7YC0cF2WGN2ZPP5g+9w6SBosI8nFtOA2JIH5+E8FKAonsJamwzvKpfYo1meIsD4i95XAUfdzHbhA8Sm0spBYqWJBsEJ/AF+wvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GvK7sq/Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uPEHmn7J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Jul 2024 19:36:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720035380;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h+okCvkGGsrUub++tHJiCL3MHZzgEoaxk7uylqcZnqY=;
	b=GvK7sq/ZFCS7tpv9pqZb9dsOkqOsGOZHaaNrgnJKQhmaczB4Q9nBHoPnBKRmGmsXbXs5e5
	sk6KUJlevT57Q/BftkcEPdx6kGnUPxNzD7tumLeXW/O94dQ3pApctX8MvMkd9ak9cuLT3/
	3hZ7BnVDE6EWfpGsskQb7L/eU3nWWFwNzRkH4nVKO7h5myAQvcmXClXcXbcKOWSXD4ytF6
	f670Yxo4QNBE79/HmI+l6sL0R6H5Kx9TvEkVp/TdXx3Y7hKRN3Cg4Ho0pJ4neUKEbqguRU
	A6le4sShW58OjPtESSCyiTHF3Pp+TVRrQYKa7FPmqjp5GFfmjI/x7xNRfYgKpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720035380;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h+okCvkGGsrUub++tHJiCL3MHZzgEoaxk7uylqcZnqY=;
	b=uPEHmn7JqCjYqnZ5kavgoC2eiSqMOonL57ZlShDq+HzVRZPiI0z+ySmf5VuEvrAi8+NRJz
	aYucQdul4WeLXsCQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] vdso: Add comment about reason for vdso struct ordering
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240701-vdso-cleanup-v1-2-36eb64e7ece2@linutronix.de>
References: <20240701-vdso-cleanup-v1-2-36eb64e7ece2@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172003537996.2215.8639468667212721241.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d00106bbdfa82732c23cba44491c38f8c410d865
Gitweb:        https://git.kernel.org/tip/d00106bbdfa82732c23cba44491c38f8c410d865
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 01 Jul 2024 16:47:55 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 03 Jul 2024 21:27:03 +02:00

vdso: Add comment about reason for vdso struct ordering

struct vdso_data is optimized for fast access to the often required struct
members. The optimization is not documented in the struct description but
it should be kept in mind, when working with the vdso_data struct.
                                                                                                                                                                                                                                             
Add a comment to the struct description.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Link: https://lore.kernel.org/r/20240701-vdso-cleanup-v1-2-36eb64e7ece2@linutronix.de

---
 include/vdso/datapage.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index d04d394..7647e09 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -77,6 +77,10 @@ struct vdso_timestamp {
  * vdso_data will be accessed by 64 bit and compat code at the same time
  * so we should be careful before modifying this structure.
  *
+ * The ordering of the struct members is optimized to have fast access to the
+ * often required struct members which are related to CLOCK_REALTIME and
+ * CLOCK_MONOTONIC. This information is stored in the first cache lines.
+ *
  * @basetime is used to store the base time for the system wide time getter
  * VVAR page.
  *

