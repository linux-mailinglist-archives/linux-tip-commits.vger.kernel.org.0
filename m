Return-Path: <linux-tip-commits+bounces-7831-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C4BD02278
	for <lists+linux-tip-commits@lfdr.de>; Thu, 08 Jan 2026 11:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCA2D304A8F1
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Jan 2026 10:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC99D3EE4E5;
	Thu,  8 Jan 2026 10:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="alr+wQk9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iOEHEr3k"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83FD3382D1;
	Thu,  8 Jan 2026 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868083; cv=none; b=XzPnozxhDJHSzFO5Q8jhJswBlUuuG+jsRtdBTc/QV4gXmCmlOlSN3Cokj6yJSm3Xf4EY3bu52oDwVAR9RDernKj53YCeTZ6IP+NNp//KhYQGpYKAN8oxbQacDXgr6uWdoJuhVUFP3TWFx9N9f9MqTr1HIhjdzWv1dynFqKLgWqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868083; c=relaxed/simple;
	bh=jQaU7M+Zu/IJ4dTuzSzn9Ny/vpFMObzYvd/r8D/uggI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Toeh56OmsPspnKqkysQmnMUcMrcjK3txwYinYKIy/5qqYAS803VjskTkZI3eI+KffDrZS1C7oV6y2Cd1YUNwisKhLlTJ1nWqUVwMclAQuIDh268dFS4jC3atdstnd4fzdgHoKbSmu4Vr3TM0XHPgiliDWfTLJfOlpRKxM2k0blw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=alr+wQk9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iOEHEr3k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Jan 2026 10:27:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767868076;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ywd1XftPpQBkwzoXasmcM6X9Rywjf2a3o5LdD/UX4QU=;
	b=alr+wQk9rg6IAlzb23LFJ8k6ysqGMVVOaLAKw35AfUcDQLCdFxn4I+/EotbS4IV1Yl2exX
	PTq9FxIlfZqZYn8DINTKLXAEV3BNXx83mR8VF8VQozOLw5gWxYt9/sCuUmg/d3dzxJpU6/
	831/I5SdZHFR9ysCvgslAu1oDgJ1//Yf/z5h6N5dNu/vqTvbT1TUpCsOAaOM9H8agARlYR
	pYK4WP4smu9PYK/OCjvYHTWkCrCpTQVCZjo0oAji/ct2cvPdA92qG+PhhMgEX7riuiY4h3
	VJ4W6Y92xSzmmlgV9VHmJ96yCvbzTRs70rTBENnbQGX1MjLBHCbr6nCHhZ4lUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767868076;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ywd1XftPpQBkwzoXasmcM6X9Rywjf2a3o5LdD/UX4QU=;
	b=iOEHEr3k0NIKz3VN//GgZU6mNwrtnL4bz1gX9tZJSEl4+wT9XduUaZIGHvg6WlWFppXDOd
	fboypm1K3fzGAjDw==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] compiler-context-analysys: Fix CONFIG_MODVERSION
Cc: kernel test robot <lkp@intel.com>, Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <aV7fxXjaOBtHhI9X@elver.google.com>
References: <aV7fxXjaOBtHhI9X@elver.google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176786807549.510.15700512179294609245.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     4d26d4a158f37cb53b22a23b4dc6c4e5bfa1369e
Gitweb:        https://git.kernel.org/tip/4d26d4a158f37cb53b22a23b4dc6c4e5bfa=
1369e
Author:        Marco Elver <elver@google.com>
AuthorDate:    Wed, 07 Jan 2026 23:35:49 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 08 Jan 2026 11:21:57 +01:00

compiler-context-analysys: Fix CONFIG_MODVERSION

The robot reported CONFIG_MODVERSION fails; which Nathan described as
so:

> Something about the context analysis makes genksyms fall over, running
> it manually on kernel/sched/core.i with '-w' to show warnings reveals
> many new "syntax error" instances. I don't see any warnings when using
> gendwarfksyms. Maybe it is context_lock_struct, as that is the first
> error I see in the list:
>
>   include/linux/spinlock_types_raw.h:14: syntax error

Reported-by: kernel test robot <lkp@intel.com>
Debugged-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/oe-kbuild-all/202512222219.F6EkVNmQ-lkp@intel=
.com/
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/aV7fxXjaOBtHhI9X@elver.google.com
---
 include/linux/compiler-context-analysis.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler-context-analysis.h b/include/linux/compil=
er-context-analysis.h
index 4f7559d..e86b8a3 100644
--- a/include/linux/compiler-context-analysis.h
+++ b/include/linux/compiler-context-analysis.h
@@ -6,7 +6,7 @@
 #ifndef _LINUX_COMPILER_CONTEXT_ANALYSIS_H
 #define _LINUX_COMPILER_CONTEXT_ANALYSIS_H
=20
-#if defined(WARN_CONTEXT_ANALYSIS) && !defined(__CHECKER__)
+#if defined(WARN_CONTEXT_ANALYSIS) && !defined(__CHECKER__) && !defined(__GE=
NKSYMS__)
=20
 /*
  * These attributes define new context lock (Clang: capability) types.

