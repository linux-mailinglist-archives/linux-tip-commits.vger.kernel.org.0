Return-Path: <linux-tip-commits+bounces-3859-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC23A4D72B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE673ABC8B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298E91FC7DD;
	Tue,  4 Mar 2025 08:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kmAaOv3y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/IbgQQDr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBF41FCCE1;
	Tue,  4 Mar 2025 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078621; cv=none; b=Y4cIA3+S/K7hrGar8fPPx6c9wvy8bofGVVA+ZkLYmYoBHPmWTJwP275Q9JrTMN3UUSWplUR/v+YXdho+zXKFsmYeVx0px4E/n8x8nZO3t4s1AjFXsVBiNi3twsaw/r6wS5j1fWQbmQhzrrXie1XKtKOI4/UFYVwkb0xBCI3HRZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078621; c=relaxed/simple;
	bh=mfEU48Ho8CCoqkm1agbxvJm1b+wLadH9LxyWiVlbaYI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MWd7LW+mYxIdy9ZX59SJg+JIt6wfTQ1lQn4EHj7be6uLAM2A7VjiU+MTSPs0FUmUgPmgS4pM1u18JR8UAw2yP6nbkkciFunO/4KIIORtKoqPzo6LUzWMr4JFRov6iOzsXwW0hmoqCDeb+jPVgPofFtixqoAJkaxmfQxQ6QuKbM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kmAaOv3y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/IbgQQDr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 08:56:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078617;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gJVOJh39CZ/Nq9wRiK42xFGoQRs8sjebANYiEGfzpPY=;
	b=kmAaOv3yXTuGgfbWkOtmRcK88dNPqrfPDouiRyyiy7ZRifPhoCobcnQWVnFxMT0Y3kprrc
	COog27sAeJcfQE9z3koUSgE+2iaDlNjkgWClw/hXX7L+oK5O5KiklwDBQR7VNTb7m/+4Vf
	sYFUb56nXeMhs1bJq5LU7gwGp5d2W6T+1XKG/khl8p/r4nBnGcGCyTpfWVOxvv60zt70Mn
	wHSuAv8lN5kn90w3e/oBckaj6K9YF5LxoDPdL28Y76HwG6Ih6WhxsA8fKohg0A+QA7IpL8
	ebwxSz/PsOIW3AKbOQhpxiVmyGw1KTK9A1Nr/v48XjVWqkspTWJDjd4m1DzJAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078617;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gJVOJh39CZ/Nq9wRiK42xFGoQRs8sjebANYiEGfzpPY=;
	b=/IbgQQDreB3MXpOkyBfwB4F+LnHv8Fvn/+a/giQxuczX66vB/zOM5jcwwHZQEFAWkp5iON
	wS6LZGaj8olJ63BA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Fix perf_mmap() failure path
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241104135519.248358497@infradead.org>
References: <20241104135519.248358497@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174107861683.14745.5838289432878648455.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     66477c7230eb1f9b90deb8c0f4da2bac2053c329
Gitweb:        https://git.kernel.org/tip/66477c7230eb1f9b90deb8c0f4da2bac2053c329
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 04 Nov 2024 14:39:24 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 09:43:26 +01:00

perf/core: Fix perf_mmap() failure path

When f_ops->mmap() returns failure, m_ops->close() is *not* called.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lore.kernel.org/r/20241104135519.248358497@infradead.org
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8b2a8c3..b2334d2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6903,7 +6903,7 @@ aux_unlock:
 	if (!ret)
 		ret = map_range(rb, vma);
 
-	if (event->pmu->event_mapped)
+	if (!ret && event->pmu->event_mapped)
 		event->pmu->event_mapped(event, vma->vm_mm);
 
 	return ret;

