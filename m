Return-Path: <linux-tip-commits+bounces-7474-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFB2C7D735
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Nov 2025 21:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E7C64E00E3
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Nov 2025 20:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665F326F2BD;
	Sat, 22 Nov 2025 20:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VGs385GO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yr3JCqFc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9EE239E80;
	Sat, 22 Nov 2025 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763843797; cv=none; b=V8hcJrJssDC8U6dE3EK0mzv8QBo1HwvkdOe55YF9QHdSJLNVMXjXaeDjYHqJcdCMtF17AxPEahCOsyzp06hVGl3wF6iFBkMlWMplVVxKBKAo2TA1uRkxf0vfel4uhMW2xa7Dq5sWA2gy50rut5nMY1JNMD7BMndDMbpjVt2S8CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763843797; c=relaxed/simple;
	bh=sBGURoA23DTRVl4bu3VnwTXp8lW4u1DFIEmL1y3IFro=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eO15uItj8E4n3DT9G9yVZIh+aLt3Ac935eQKTJVnboCNkKUH9ppL/FW+9YZrJ9B07VKVGKTut7y+Fl0sc4dWXqOkJQdeK2v/fdWsQJEy9iWAMbG8o/s584dqXynqSG0ivLihP/Zm2Aa80HILQGC0WleAyPnng+vwZnVwWtzjjmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VGs385GO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yr3JCqFc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 22 Nov 2025 20:36:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763843788;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JUcSnOrurmG2+HxdnGHeuyMGX/jNk9bnoga8Wx90VE4=;
	b=VGs385GOA3Jt5IScNFsu0APTQ6Xwv1ljIK0/7QorFOSlvCTk6wSSbIAY0PmLuBo63knQl4
	OjtNKLkYUFmYJr7DSTNKBda8xqGW9TTa8qQzPvJjv/BMvhG9xTBXtsv1zi0PSU1XmyzTIp
	0jFgk+pJMoQEDACyT1kjnuy6g0/uJPGDyaLNejekuQv++VK3fgb1TjRK5rg/HgnNiRVuuL
	6uhNKU3C/b0ex6VUkDXygKJE8qFJHTeBUtl5ZHqzLvU+Z/IU4FctdvUZkjhrOxeF4GuyDY
	j+mhAyTT2oQuhxzHTQKQOjOgNLleA5qC0jzM4F8Dr8StLSI6isxkl5PdS0T/2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763843788;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JUcSnOrurmG2+HxdnGHeuyMGX/jNk9bnoga8Wx90VE4=;
	b=yr3JCqFcR8CD8DL+q6X1rhU997EYLGdjCOgiJYhXedfBxPYVvhe55OGiQjXfmNBXJDMQai
	54TV9HCdMaLsKGDQ==
From: "tip-bot2 for Yue Haibing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cleanups] x86/{boot,mtrr}: Remove unused function declarations
Cc: Yue Haibing <yuehaibing@huawei.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251120121037.1479334-1-yuehaibing@huawei.com>
References: <20251120121037.1479334-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176384378656.498.412814564621420954.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     e6a11a526ec63e456d725f67cebcf4f42b2ec2aa
Gitweb:        https://git.kernel.org/tip/e6a11a526ec63e456d725f67cebcf4f42b2=
ec2aa
Author:        Yue Haibing <yuehaibing@huawei.com>
AuthorDate:    Thu, 20 Nov 2025 20:10:37 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 22 Nov 2025 21:26:36 +01:00

x86/{boot,mtrr}: Remove unused function declarations

Commits

  28be1b454c2b ("x86/boot: Remove unused copy_*_gs() functions")
  34d2819f2078 ("x86, mtrr: Remove unused mtrr/state.c")

removed the functions but left the prototypes. Remove them.

  [ bp: Merge into a single patch. ]

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20251120121037.1479334-1-yuehaibing@huawei.com
---
 arch/x86/boot/boot.h            | 2 --
 arch/x86/kernel/cpu/mtrr/mtrr.h | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
index a3c58eb..8e3eab3 100644
--- a/arch/x86/boot/boot.h
+++ b/arch/x86/boot/boot.h
@@ -193,8 +193,6 @@ static inline bool heap_free(size_t n)
=20
 void copy_to_fs(addr_t dst, void *src, size_t len);
 void *copy_from_fs(void *dst, addr_t src, size_t len);
-void copy_to_gs(addr_t dst, void *src, size_t len);
-void *copy_from_gs(void *dst, addr_t src, size_t len);
=20
 /* a20.c */
 int enable_a20(void);
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.h b/arch/x86/kernel/cpu/mtrr/mtrr.h
index 5655f25..2de3bd2 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.h
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.h
@@ -46,10 +46,6 @@ struct set_mtrr_context {
 	u32		ccr3;
 };
=20
-void set_mtrr_done(struct set_mtrr_context *ctxt);
-void set_mtrr_cache_disable(struct set_mtrr_context *ctxt);
-void set_mtrr_prepare_save(struct set_mtrr_context *ctxt);
-
 void fill_mtrr_var_range(unsigned int index,
 		u32 base_lo, u32 base_hi, u32 mask_lo, u32 mask_hi);
 bool get_mtrr_state(void);

