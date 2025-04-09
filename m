Return-Path: <linux-tip-commits+bounces-4816-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6F3A830AA
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 21:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E28F67A96C6
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 19:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A201F8743;
	Wed,  9 Apr 2025 19:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wpkrWXcx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0iuoqDOl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E801F560D;
	Wed,  9 Apr 2025 19:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744227665; cv=none; b=o2zBiJYly+iIEWuCKITAYWAleOMuukwk/oe4iL52RcxRR4J2HxqtMkIvU1FJJ3LiUvLFa3s6HAI85JcrrmapllZtWFebn8IvvPRh+stY8H1R9fNJkZvrwdYBSrzoBYxevhdEO0VV9SCympkFI0M7nqtiO+PiEsIf7SY41zSEP5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744227665; c=relaxed/simple;
	bh=FONNNLpNszA+2VgSXpk27JRsfON/wOEDohacKJXv02I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gqm2mbgXnQMtFJg7gGUylyds45NpfxOpj98hq5aNGktTpwtB6dZ2GrjsvzUO6ddjA4zcE3rCzOVKfZHUXyACtrGPfaC8LviGPV5QU5vBUPmvzepv/r3ItbPwIeQqvCo1ft+8TjnpIsfl7uC+/BgOP9VkWLXPd6eMK77hgQ9Cs9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wpkrWXcx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0iuoqDOl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 19:41:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744227662;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lsh8Weqe35wkxh/rd80IIqiq+0ebbjhbrBUNymkZMuE=;
	b=wpkrWXcx2FE7zgIpzSOKN0YvApjlRKWdJ86yShiRXFbR7wZEOG+4B/PUsDPD9zwL1SW0tx
	8MF9IBVhhDIAW1gaY9a5OETP7iNtR0kI9/5A/Ju4L4R8qrgfSwZkvXDD/yMs28wLyQ9oY9
	2ZZloNRrZEHeUYqACfuB9GbwWXNbvoRmb6V5O6HLDhgIHOL5tgITNLoSO8e/okN9j+PO/H
	dHHFyzheMbI3x3HMQDQszEHoaAOsofCDZYuW1P8vOIqniqiG5pRsXEyw34lTiwo1TQcqGU
	OSad+H9ubI7arVZEidCd5cjLSSxwZQnKG4NYuMv/wM1Ls/vQMFs2u3TKxorGOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744227662;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lsh8Weqe35wkxh/rd80IIqiq+0ebbjhbrBUNymkZMuE=;
	b=0iuoqDOlf8TBxwsop0YyD2mYogOZw+X2PqFQhO4h5KyJje065JY4/SUGPtVbKY8AlGbScO
	bnlynayVQ/4VBABQ==
From: "tip-bot2 for Malaya Kumar Rout" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] selftests/x86/lam: Fix clean up fds in do_uring() and
 allocate_dsa_pasid()
Cc: Malaya Kumar Rout <malayarout91@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250409135341.28987-1-malayarout91@gmail.com>
References: <20250409135341.28987-1-malayarout91@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174422766185.31282.16212941826628695092.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     60567e93c05d7064c93830cf4bf0d2c58f11b2f2
Gitweb:        https://git.kernel.org/tip/60567e93c05d7064c93830cf4bf0d2c58f11b2f2
Author:        Malaya Kumar Rout <malayarout91@gmail.com>
AuthorDate:    Wed, 09 Apr 2025 19:23:37 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 09 Apr 2025 21:30:37 +02:00

selftests/x86/lam: Fix clean up fds in do_uring() and allocate_dsa_pasid()

Resolve minor fd leaks reported by cppcheck in lam.c.

Specifically, the 'file_fd' and 'fd' were not closed in do_uring()
and allocate_dsa_pasid() functions, respectively.

cppcheck output before this patch:

  tools/testing/selftests/x86/lam.c:685:3: error: Resource leak: file_fd [resourceLeak]
  tools/testing/selftests/x86/lam.c:693:3: error: Resource leak: file_fd [resourceLeak]
  tools/testing/selftests/x86/lam.c:1195:2: error: Resource leak: fd [resourceLeak]

cppcheck output after this patch:

  No resource leaks found

While this is a standalone test tool that doesn't really leak anything
in practice, as exit() cleans it up all, clean up resources nevertheless.

[ mingo: Updated the changelog. ]

Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250409135341.28987-1-malayarout91@gmail.com
---
 tools/testing/selftests/x86/lam.c |  9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 18d7366..0873b0e 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -682,7 +682,7 @@ int do_uring(unsigned long lam)
 		return 1;
 
 	if (fstat(file_fd, &st) < 0)
-		return 1;
+		goto cleanup;
 
 	off_t file_sz = st.st_size;
 
@@ -690,7 +690,7 @@ int do_uring(unsigned long lam)
 
 	fi = malloc(sizeof(*fi) + sizeof(struct iovec) * blocks);
 	if (!fi)
-		return 1;
+		goto cleanup;
 
 	fi->file_sz = file_sz;
 	fi->file_fd = file_fd;
@@ -698,7 +698,7 @@ int do_uring(unsigned long lam)
 	ring = malloc(sizeof(*ring));
 	if (!ring) {
 		free(fi);
-		return 1;
+		goto cleanup;
 	}
 
 	memset(ring, 0, sizeof(struct io_ring));
@@ -729,6 +729,8 @@ out:
 	}
 
 	free(fi);
+cleanup:
+	close(file_fd);
 
 	return ret;
 }
@@ -1189,6 +1191,7 @@ void *allocate_dsa_pasid(void)
 
 	wq = mmap(NULL, 0x1000, PROT_WRITE,
 			   MAP_SHARED | MAP_POPULATE, fd, 0);
+	close(fd);
 	if (wq == MAP_FAILED)
 		perror("mmap");
 

