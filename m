Return-Path: <linux-tip-commits+bounces-3014-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD319E78A3
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 20:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A59D16C2B9
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 19:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EEC202C50;
	Fri,  6 Dec 2024 19:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xo3n9vfz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4L88nQDh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7641FFC40;
	Fri,  6 Dec 2024 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733512362; cv=none; b=q3dyB0HabLNKWTkSzUgArkrQzfH8clZ3vnEpLuMPiKKtn2Rl0VhmzS0S6/xHJJv+ZYqfgtGByULnnNvigNWuovmgJn3F/PRSZDqkjj9J5uMpNgBtWZhYKJjMmzjMbCe9olCJjEV4uv2EypnZUEea97/2ZWODOCSpuqxI3y7oUsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733512362; c=relaxed/simple;
	bh=QApkVxfYHRJMExjrJLAMokMJBKbPzLkcltojfQoQx6Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HBxC82di3uxVPeQAQfuzVjQ4kxm/1Sh9StCxOtLwWYVZcTeP8A2Gfr9q8OrLckgb1NzTeGmxNADvByiSn1XEnYVv4FqNazXEDr51BwcyTeEXFS6DdNzkNl1sK+dBBPuRrHH2pAwQf9+A5EwaGsYntXvB/xfOrwWsinOAeokrEeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xo3n9vfz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4L88nQDh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Dec 2024 19:12:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733512359;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xljc9qTrI69As495Y/YKVl9bDzr/j2L9KdrAxIaEiJE=;
	b=Xo3n9vfzJxSHNK7/km7VLJH3KmBD2epQG4idwlCAVxiSXol4ZGYHFXBhPojIHnrRlkoBjb
	vYT3dnbASoM+Fe3L8K1Bv48V3md0iO0aUjZNMhW6vMHR/TlmsBGrhsU50mPPXNPcnDHshy
	OJzhoy/H9oV5/FnfYo0z4WVj1wmTdTppcTcqT5yfPSwY63DRU8mf7KRVtIEWMO+i/SeVp+
	gnstiKdUImthPXUDQ2pbxmdh6d/shQif8fE94YCGKizfts+v7zRdGFoCJXOVaP/QrZ1lFB
	OsuYqnW1A0+lebsPhnxdKGKj3Jff4EeIB1qBjWYSqi9Ey4VWyKLC9wQj3p5Alg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733512359;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xljc9qTrI69As495Y/YKVl9bDzr/j2L9KdrAxIaEiJE=;
	b=4L88nQDhYWjk5ffOExoyNR5SeTZGZa4Digfd2TEEaubdJf9yS7jKrWJn4ZVsB4ZVzkDZTF
	vBk1av3x7ammEzAg==
From: "tip-bot2 for Gautam Somani" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/selftests: Fix typo in lam.c
Cc: Gautam Somani <gautamsomani@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241130184102.2182-1-gautamsomani@gmail.com>
References: <20241130184102.2182-1-gautamsomani@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173351235881.412.10396233513650012252.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     9d93db0d1881c9e37e1528cd796e20ff13b7692c
Gitweb:        https://git.kernel.org/tip/9d93db0d1881c9e37e1528cd796e20ff13b7692c
Author:        Gautam Somani <gautamsomani@gmail.com>
AuthorDate:    Sun, 01 Dec 2024 03:41:02 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Dec 2024 20:04:32 +01:00

x86/mm/selftests: Fix typo in lam.c

Change the spelling from metadate -> metadata

Signed-off-by: Gautam Somani <gautamsomani@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241130184102.2182-1-gautamsomani@gmail.com
---
 tools/testing/selftests/x86/lam.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 0ea4f68..4d4a765 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -237,7 +237,7 @@ static uint64_t set_metadata(uint64_t src, unsigned long lam)
  * both pointers should point to the same address.
  *
  * @return:
- * 0: value on the pointer with metadate and value on original are same
+ * 0: value on the pointer with metadata and value on original are same
  * 1: not same.
  */
 static int handle_lam_test(void *src, unsigned int lam)

