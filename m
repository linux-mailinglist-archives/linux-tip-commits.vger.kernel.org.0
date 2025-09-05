Return-Path: <linux-tip-commits+bounces-6501-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42632B46539
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Sep 2025 23:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 269E0189F45C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Sep 2025 21:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF2A2ED143;
	Fri,  5 Sep 2025 21:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TfK+8KM6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/a/RIz27"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026212EA493;
	Fri,  5 Sep 2025 21:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757106668; cv=none; b=uoYMdaqPxy5HEt1yaRR5lt9IArJJdN79QcOiuL029w8mpCd3H0Ff7BxFaUWCZaBDHtJgD16N0sn4vh6vwv2/zxljSWoulAm8TjKzedhEZOe1RV/kcPfPT9DZBQl/Vn6C7KwryZPyedGeuzNk6zb+cRUFbEndBjeoyzlPWqNJSDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757106668; c=relaxed/simple;
	bh=znCNu58A9bbkI+V+cQofTFIn4B73K6qagheSr2yA+VQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=E6XeDtrOxuYeGldwZ/uPC+f+elVXq4npWRAvshq64FhyjGe47l5cGtqqfOYimtcWg65t2DbMLC0ifJrDesdixSvXK4N/EB72+Z5r8MhNdIXuLbDNqnUAmZaeFDU5AbCR1eBGBCylITrMqoY570U2RgwOPCnDDP9o+zN/mCe3VjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TfK+8KM6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/a/RIz27; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Sep 2025 21:11:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757106662;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DkiEYWYz/NyqpBfKmEaqPDHv4PxuOCGA7nc85qYysAM=;
	b=TfK+8KM65QEEdMUS7nbmB1xvcsRUygKEYU7f+EWQcsLM0CSVwt23Cu4OZGQkF4BP/QZs7p
	uVD1X2IxTSunvswdV3K5p4O28lm4KaQSS2krk2wsSDSHtHDNw9oydWB2WFwptUm9esmF5d
	R5114FDiHt7zsYNAbjBYDNqnl4xMBy5ov+fN3EpJLzNvyWSbrGzmLAfgRPD0xypqimSTLk
	KGaBHaBcCp7r2ItjcgOLfssJ+VU6kreuHRKhaLxnFsa2mjeeGv/bfqxrYJic9cnrUr7rzs
	xUjgBdcdAHEywfX9EQBa6+++qa77/8uvWitInmslmBetydM7ilQaW0NIAr9d3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757106662;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DkiEYWYz/NyqpBfKmEaqPDHv4PxuOCGA7nc85qYysAM=;
	b=/a/RIz27oECKKGvI1hfjBceiM1dPj50wnENes8rmre6GZhf/r3yIcP5H+xBf9GEyWyr2eR
	Nm6WnoTCmavpDhAQ==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso: Add struct __kernel_old_timeval forward
 declaration to gettime.h
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250815-vdso-sparc64-generic-2-v2-1-b5ff80672347@linutronix.de>
References: <20250815-vdso-sparc64-generic-2-v2-1-b5ff80672347@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175710666021.1920.18083277458644179546.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     437054b1bbe11be87ab0a522b8ccbae3f785c642
Gitweb:        https://git.kernel.org/tip/437054b1bbe11be87ab0a522b8ccbae3f78=
5c642
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Fri, 15 Aug 2025 12:41:10 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 05 Sep 2025 23:04:35 +02:00

vdso: Add struct __kernel_old_timeval forward declaration to gettime.h

The prototype of __vdso_gettimeofday() uses this struct.  However
gettime.h's own includes do not provide a definition for it.

Add a forward declaration, similar to other used structs.

Fixes: 42874e4eb35b ("arch: vdso: consolidate gettime prototypes")
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250815-vdso-sparc64-generic-2-v2-1-b5ff80=
672347@linutronix.de

---
 include/vdso/gettime.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/vdso/gettime.h b/include/vdso/gettime.h
index c50d152..9ac1618 100644
--- a/include/vdso/gettime.h
+++ b/include/vdso/gettime.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
=20
 struct __kernel_timespec;
+struct __kernel_old_timeval;
 struct timezone;
=20
 #if !defined(CONFIG_64BIT) || defined(BUILD_VDSO32_64)

