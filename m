Return-Path: <linux-tip-commits+bounces-2102-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF40495D59B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2024 20:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9D5285E7F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2024 18:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FFD19258B;
	Fri, 23 Aug 2024 18:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oVfviTlK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+nzFChjE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC154192588;
	Fri, 23 Aug 2024 18:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724439243; cv=none; b=MwTSzrJA5MhswPwBepVU25ewr22DT9DRmo7BIJwbbyZyILeJmXYyPdKrZJzT1NtxJOqn/snjvm0NHQV6fracME3oogvR561fNg3eXxuCf3EQpuWZB5Siuh5RVT0imIhDIvR7eUdwOrr0CEl6PEGMpGnhllOUnDgUtQZCilmjoY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724439243; c=relaxed/simple;
	bh=chJn+kVoLlDK5e+6EVGOogrD6JGxvm9hwQ/8Df81fdE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aWRJqEIIeo2fLGWgUCw8OtfoQHWo56B7l1KjVghgW1q2DvQtUFdJuFrc1w7enPpPt1+O4EIfedowSsCUcsITfVwnltUnxKI3zBsq6SUYLxw6TQo7K/TLZh6G4YOIEndXpjWB/G6b4BMr7+YWtAND4bgF9N0RZr4O0shMa32XKJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oVfviTlK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+nzFChjE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 23 Aug 2024 18:53:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724439240;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eX/wVScsZ4rTrV/m4Tck4sj2Li35EnjINVp6aocqQps=;
	b=oVfviTlKHux1aw1lWT/trUvDczi4x5uD70JMPMxrt61viHWMDT0K+aqsLRAH2ghzYG8aKw
	8gdQvf0KnqDHh9/BAGhQ9UrYEIGlRFzehF/xS9nwkkTpR4jZt5bdnRUUqUnIZQE/UemPGu
	X1+AVLH9Oe+4hVwsPF6nCYHtNQ310wPmj/TQf6N1TDvybPZJJLEN2F03gmnpqkhWTvjbw1
	lSgsiF+6iaZdiKE5f6jY0Wetlv84d/BY3GTv9N94RarKXC7lDNh4z1EGEHAnWJMg17VVy/
	zX/eZXZCFyZBs+abtdc9z/Y8bzaorFwuemZaudmDFNDGZ57WuchLjS/pKgPK0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724439240;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eX/wVScsZ4rTrV/m4Tck4sj2Li35EnjINVp6aocqQps=;
	b=+nzFChjEUqtLZKV7LV4Zk132VHNUYcYg1Yn+p5LRqqMcgrEiXPgTy5LgHRU4ZzHPqzlgoh
	4vlMyYaZ7vENS9Dw==
From: "tip-bot2 for Costa Shulyupin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Fix typo in struct comment
Cc: Costa Shulyupin <costa.shul@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240822123205.2186221-1-costa.shul@redhat.com>
References: <20240822123205.2186221-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172443923970.2215.1313137188853169807.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     17e28a9aeae40d2de3c1ea3b94819ed94bfd6392
Gitweb:        https://git.kernel.org/tip/17e28a9aeae40d2de3c1ea3b94819ed94bfd6392
Author:        Costa Shulyupin <costa.shul@redhat.com>
AuthorDate:    Thu, 22 Aug 2024 15:31:58 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 23 Aug 2024 20:50:19 +02:00

genirq: Fix typo in struct comment

Remove redundant "e" in "assign(e)ments".

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240822123205.2186221-1-costa.shul@redhat.com

---
 include/linux/interrupt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 694de61..457151f 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -276,7 +276,7 @@ struct irq_affinity_notify {
 #define	IRQ_AFFINITY_MAX_SETS  4
 
 /**
- * struct irq_affinity - Description for automatic irq affinity assignements
+ * struct irq_affinity - Description for automatic irq affinity assignments
  * @pre_vectors:	Don't apply affinity to @pre_vectors at beginning of
  *			the MSI(-X) vector space
  * @post_vectors:	Don't apply affinity to @post_vectors at end of

