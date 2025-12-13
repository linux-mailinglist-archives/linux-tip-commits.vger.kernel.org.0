Return-Path: <linux-tip-commits+bounces-7643-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A32CCCBA7F4
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Dec 2025 11:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E635030680F0
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Dec 2025 10:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CDB2F4A1F;
	Sat, 13 Dec 2025 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xm5KLY9r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2ZF0w7no"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5897E2773F;
	Sat, 13 Dec 2025 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765620441; cv=none; b=fZYWaPlfKWXIZXPbaOohqKnE0LMlpBoKjrfbpWAbKCz0m7FF2uXArUS+iJzLY2v9lKIcAeanXp2kM5FMjjmVEIJjZJBQ2dOVW8VXYZj6a/XzROkgBM7naYP3oa2i1ZprJYXz1/WDBz3vzryXPNQ3ZM1d85l2h43GZTKtiNGQW7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765620441; c=relaxed/simple;
	bh=6lSbXpDmQO5ZFhR+/pbf+llffxsX33jEU1cMDl+P7z4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=V6bQCmCz9xzSNbqqm88ypEOo5z5SUoBpiKZFLeeQnZ8j8/yMREgPRC/mD2/oR1rENjZsxLLxPDyVwGHf1z4WwSZr2I5BQZaQhZaXZnJ+ukTye6TkbM6JaDJQYLP0iIae472eEVJfjr99pnerDO3Wl636pq1OuGq3c8Luv6H7n2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xm5KLY9r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2ZF0w7no; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Dec 2025 10:07:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765620436;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qf/HZ/jAbeftVN1oVFRqI0Pc74FLwlByVdAvqhAVJo4=;
	b=Xm5KLY9rXHEzOxW5MYOEJOx0BxQGI/vllT0UnzuJX2utrdl7WVYIHeKFkGloADyPTwNOdI
	rT5IozO9nVFkojrLPa5IHAaYZs+PS7+VTbgGMnNEqH/CVVjFyXuAg4KvEVBiN3eJM7/Lrm
	IeDMLOvmuWr+M4PXh7Gwi7wL3tEnboAXSdwT1Z3WhPJGP1sh7IEureS16hBesh/MnSBzyk
	NgNjpxGrRcvoL31y4C9QLJ/QqmhTkc2OpNnjQJOWgqU2wG2E/DjuGaJl4LzdS9mjFZdG+5
	Fo7bNi504q20vT77QLsx25ILQfY0M7zecJy8iD/M2HqaGl3kcxz8bd2VD7v7Zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765620436;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qf/HZ/jAbeftVN1oVFRqI0Pc74FLwlByVdAvqhAVJo4=;
	b=2ZF0w7nofIjzzwtAD3QzSmnds2Q02tZUr56wHPYbP9uYvQEnRTBCjNjKxym9joGkHTBtlf
	fUMpIFh+4cxS/rAw==
From: "tip-bot2 for Tal Zussman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] mm: Remove tlb_flush_reason::NR_TLB_FLUSH_REASONS
 from <linux/mm_types.h>
Cc: Tal Zussman <tz2294@columbia.edu>, Ingo Molnar <mingo@kernel.org>,
 Rik van Riel <riel@surriel.com>, David Hildenbrand <david@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251212-tlb-trace-fix-v2-2-d322e0ad9b69@columbia.edu>
References: <20251212-tlb-trace-fix-v2-2-d322e0ad9b69@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176562043497.498.5430010912843136128.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     0c01ea92f545ca7fcafdda6a8e29b65ef3a5ec74
Gitweb:        https://git.kernel.org/tip/0c01ea92f545ca7fcafdda6a8e29b65ef3a=
5ec74
Author:        Tal Zussman <tz2294@columbia.edu>
AuthorDate:    Fri, 12 Dec 2025 04:08:08 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 13 Dec 2025 11:01:16 +01:00

mm: Remove tlb_flush_reason::NR_TLB_FLUSH_REASONS from <linux/mm_types.h>

This has been unused since it was added 11 years ago in:

  d17d8f9dedb9 ("x86/mm: Add tracepoints for TLB flushes")

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Rik van Riel <riel@surriel.com>
Acked-by: David Hildenbrand <david@redhat.com>
Link: https://patch.msgid.link/20251212-tlb-trace-fix-v2-2-d322e0ad9b69@colum=
bia.edu
---
 include/linux/mm_types.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 9f6de06..42af229 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1631,7 +1631,6 @@ enum tlb_flush_reason {
 	TLB_LOCAL_MM_SHOOTDOWN,
 	TLB_REMOTE_SEND_IPI,
 	TLB_REMOTE_WRONG_CPU,
-	NR_TLB_FLUSH_REASONS,
 };
=20
 /**

