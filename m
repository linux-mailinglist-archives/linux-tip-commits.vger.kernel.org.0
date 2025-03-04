Return-Path: <linux-tip-commits+bounces-3958-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37657A4ECE5
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 20:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 862C87A1B54
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C68253B75;
	Tue,  4 Mar 2025 19:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W6FLAw6O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kSDF5jxY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4270A1EEA36;
	Tue,  4 Mar 2025 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741115552; cv=none; b=t7v/JA06VvwRnpNBybYHcvcjBkYovYa4otknLITrNMO9REW3j6GX80Dnv+bvRIdkDaFnDgB8Ng5XnM1D63Yy12lg85dGlGJhpdGO7HM3v8qqnrehMjpnF04/WLp5Stt3DckKTL/eZ7HrUv+nVLKbTnZQjQO2B3rWo9jyUJ2xnKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741115552; c=relaxed/simple;
	bh=pFcur4LhuU6e7exEBimRKYlZhg0Ha9BKAc0GUJNEMGM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fVeGVmHCoRWnlyZbC5PEMcWciJxKdGMhC3c+1mE0JlslpOHhIC4iDr+SPeo66HZq9lojeD9f7Y+PlF9l+H9ZooO5G4T3iby/HxjdZIPd9AsnPlvPTVh9P+E3JTUJvQBuEjdusVKjZ/vIT0RRBZ2oQstRRIeTXnKlB8K4doVbYSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W6FLAw6O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kSDF5jxY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 19:12:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741115549;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vdfWzjh5f8yU2E686H+/CLEZdKtId2rsdnVtVaeCwGY=;
	b=W6FLAw6OMPwzebe2HBezMvAysuU91LRybJEwTTDZwyRIEjh60/7K6ucpar6NyfhuV+wS05
	v2piG5uG1MYkyd8TaRltI5wqyEaAdJJkkZA3pKy74rr0Ndyv2nvvUD52v+VNfHiYiSSoYW
	dxIb7KQr+KqbVyDiZM1SYDUHWgqmwdp3Es8rJDRr3HRr34R87saoFpQZL/IFrMkKoB5RDs
	eXSWq2tgq0LFta4XtIdnLvyBIqObPJM+CD0BuAgmZ76KZ1QqN/zo0mhF8w8zjTrsOt/UjJ
	SJGmduxury8yg/MaM1A1cQTocrcv/xqQeRJpQlbKyY4BZZYy5dHlEt95LB8TGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741115549;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vdfWzjh5f8yU2E686H+/CLEZdKtId2rsdnVtVaeCwGY=;
	b=kSDF5jxYZWc/zcWbzFIe3MGw02/ibEDqpW97iKYJHJzaXOKX5Kvmh/EwZVun9LuOFF0A9N
	Cz9tajr4OHbVHSCg==
From: "tip-bot2 for Thorsten Blum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86: Annotate struct bts_buffer with __counted_by()
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250304183056.78920-2-thorsten.blum@linux.dev>
References: <20250304183056.78920-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174111554764.14745.14213573362217486017.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     077dcef270361089c322a969b792438b33cfb479
Gitweb:        https://git.kernel.org/tip/077dcef270361089c322a969b792438b33cfb479
Author:        Thorsten Blum <thorsten.blum@linux.dev>
AuthorDate:    Tue, 04 Mar 2025 19:30:57 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 19:58:01 +01:00

perf/x86: Annotate struct bts_buffer with __counted_by()

Add the __counted_by() compiler attribute to the flexible array member
buf to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Use struct_size() to calculate the number of bytes to allocate for a new
bts_buffer. Compared to offsetof(), struct_size() has additional
compile-time checks (e.g., __must_be_array()).

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250304183056.78920-2-thorsten.blum@linux.dev
---
 arch/x86/events/intel/bts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 8e09319..debfc18 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -58,7 +58,7 @@ struct bts_buffer {
 	local_t		head;
 	unsigned long	end;
 	void		**data_pages;
-	struct bts_phys	buf[];
+	struct bts_phys	buf[] __counted_by(nr_bufs);
 };
 
 static struct pmu bts_pmu;
@@ -101,7 +101,7 @@ bts_buffer_setup_aux(struct perf_event *event, void **pages,
 	if (overwrite && nbuf > 1)
 		return NULL;
 
-	buf = kzalloc_node(offsetof(struct bts_buffer, buf[nbuf]), GFP_KERNEL, node);
+	buf = kzalloc_node(struct_size(buf, buf, nbuf), GFP_KERNEL, node);
 	if (!buf)
 		return NULL;
 

