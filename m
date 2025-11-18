Return-Path: <linux-tip-commits+bounces-7404-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D99C6B9EA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 21:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C387E4F6777
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 20:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61409370310;
	Tue, 18 Nov 2025 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bibqq++S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e4Sn2fxI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB8A370317;
	Tue, 18 Nov 2025 20:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763497229; cv=none; b=GIe8D+W/VJMAEi3l6zKS18cXc6g55V/YlfQoICLVwm5RU1unmDziublfJ6+Qp8YsgUr80LA3qYAs8fHBXfsSbO0KE4rjyXRSr1B1C5IVOW9+89UiDSq/fMBJm5NrQnMDlHBwzDzVt+hruHBT+B2U+6CdEGUacef5kzw0IcgVq9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763497229; c=relaxed/simple;
	bh=q+rRXOGk850g/ytkwzU5fI0C1QujKNDz74eap3gZJuM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ylb9i2ICFxhUtK6Bfwyx99U9bevGRZwaN3PlxHvmnJsY8HGNlkil1pwXHHBw+CeeBAheKfX6EKWRlXZfTmkF7SfDmTtjE+7q8PAnEcOo/b7W9MJgnWJSijZ4MrAMHrVIbteQu6hHyMRnKdo99eXXaBgtAicdCINdOTnd6lMc9HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bibqq++S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e4Sn2fxI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Nov 2025 20:20:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763497225;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tWmJVCWq1hW3DCTLMvrCujqOemALs2jmK2H2oiMtpZo=;
	b=bibqq++SmJa+/0VLsB0Xa0v3uKMlCo7ghWmSG6N4ufooQXfqjBEUn8c9ZvgX/0xZmSfZ/9
	PhG9O+lhbEQgvdDnBNzsJHqasmHONoBRTYg3V4k3l6XkSHHobyvSG2+CWq8eTN3WU03n1F
	jKCjFTXwVLWBjJ7NzhDyvfCGxTIINKXzxpyY+zGRDcAXgZjsmnepNOB6AnOQHY7dY5o0Ld
	4FOvsq4r6pA3XgfLgb4Ce9iMsRXs3mN34g2Dpizp1Mos0NcrjQmToXCds2fguU5Lz31fMT
	2b6V+4UfugLPOdPyntCdyxHiKoQxb+6hV7fuq8eoHiZ1OlThU62PTrl6D6Y0GQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763497225;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tWmJVCWq1hW3DCTLMvrCujqOemALs2jmK2H2oiMtpZo=;
	b=e4Sn2fxIRov8gCrjbLgb34fJXhECFgqTN+GNxzHdru0kn6/Rt0lz5hBwWLtNJ5FTuzpEa+
	YuGAhoYoZC7owBDA==
From: "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] fs/resctrl: Consider sparse masks when initializing
 new group's allocation
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cabbbb008bc09d982d715e79d3b885c10f92c64e0=2E1763426?=
 =?utf-8?q?240=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3Cabbbb008bc09d982d715e79d3b885c10f92c64e0=2E17634262?=
 =?utf-8?q?40=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176349722422.498.12794148933047234636.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     5a88a6e92bbf5963fadeb0e8f8c747c2fb425ba8
Gitweb:        https://git.kernel.org/tip/5a88a6e92bbf5963fadeb0e8f8c747c2fb4=
25ba8
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Mon, 17 Nov 2025 16:42:45 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 18 Nov 2025 21:10:56 +01:00

fs/resctrl: Consider sparse masks when initializing new group's allocation

A new resource group is intended to be created with sane defaults. For a cache
resource this means all cache portions the new group could possibly allocate
into. This includes unused cache portions and shareable cache portions used by
other groups and hardware.

New resource group creation does not take sparse masks into account. After
determining the bitmask reflecting the new group's possible allocations the
bitmask is forced to be contiguous even if the system supports sparse masks.
For example, a new group could by default allocate into a large portion of
cache represented by 0xff0f, but it is instead created with a mask of 0xf.

Do not force a contiguous allocation range if the system supports sparse mask=
s.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/abbbb008bc09d982d715e79d3b885c10f92c64e0.17634=
26240.git.reinette.chatre@intel.com
---
 fs/resctrl/rdtgroup.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 0320360..41ce4b3 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -3383,11 +3383,12 @@ static u32 cbm_ensure_valid(u32 _val, struct rdt_reso=
urce *r)
 {
 	unsigned int cbm_len =3D r->cache.cbm_len;
 	unsigned long first_bit, zero_bit;
-	unsigned long val =3D _val;
+	unsigned long val;
=20
-	if (!val)
-		return 0;
+	if (!_val || r->cache.arch_has_sparse_bitmasks)
+		return _val;
=20
+	val =3D _val;
 	first_bit =3D find_first_bit(&val, cbm_len);
 	zero_bit =3D find_next_zero_bit(&val, cbm_len, first_bit);
=20

