Return-Path: <linux-tip-commits+bounces-7795-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 587E5CF49AA
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 17:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2DC23158292
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 16:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B6F3451A6;
	Mon,  5 Jan 2026 15:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i0HpW4GU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X/3W3kJv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF0533A9EF;
	Mon,  5 Jan 2026 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628464; cv=none; b=gRdhpHLuEOrpKRkdNiCf8c8odXmwt0cQzeca8spI65pPceHCywS03MxFZFDtjCisVYsDpMBZTOKBMM+yTpHUpmwgt5G6RmOcQzbGlis0jAKznQsov4Y9GfErkjpVyQM77zeFnzOhUBBqZc6aIrVdeij+QDkL8QNJSnDsU8jmD2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628464; c=relaxed/simple;
	bh=C4N3ogqK2NgLASluCjh3NyCixkUwm5GTzXh00UN04cE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nHDha6ZSN12EVHgvv8Vx9g6qFvCM+c5icfRt84ZRvvHhA3095Sz3Am7CaPwnJd8Lu5A071G3ztVlzqwnLFLOjyilLEUx8RBwrOsEr3lX/rMOpMDDbBVnqgxruWHXUF7S3r9jS1Y3iJk7hIMdehnCkgDE6RctHgQ+nGfPeY+n6WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i0HpW4GU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X/3W3kJv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:54:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767628461;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NcwiX/r3e+LWbQNi7SHXMMDu48+7GqVGSjV5SlS6li8=;
	b=i0HpW4GUgmBjLTcAMRCJoJyYrJ5CZ9/3QsteJtKYcVEylssgF0yFggFegGTK5RvcNGXg18
	F4yBxlflv9PTfUUn5Y0+qO4Qt/4JDta6M9EBpYKjNKo1n+SWvkjRNlXvLWiLWnHGXBGTEB
	1VgDb/TSgggJ/l7TDJ9yKovMpFhdYb469uIP9nWMSGC0RFv6ln8z5FdnxxEc4Dkq8DVr85
	iC8ub76Trfc46NKUAw7MavizNbt4i2htpJK7aZEYahgrc6sDMu9x1mU2OT5WopzAF+eQRr
	1of2UmaLf/Fq5c9y3z8L/bbUXCaoLcdGuJ9sVIWAFVWD6Jh2Lj4adSZE33OADg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767628461;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NcwiX/r3e+LWbQNi7SHXMMDu48+7GqVGSjV5SlS6li8=;
	b=X/3W3kJvlWWYgiRi6wrlLbK8lKDs7sKJ8KAGk13ARONp+SuLZmt2cFBZlN7HnmTF7agUWn
	4x9x7pIOhoVL0QBg==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] MAINTAINERS: Add entry for Context Analysis
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Bart Van Assche <bvanassche@acm.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251219154418.3592607-28-elver@google.com>
References: <20251219154418.3592607-28-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762845980.510.5935312470055307220.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     48eb4b9a3d5c305f93d3cfd0eddffa305884597f
Gitweb:        https://git.kernel.org/tip/48eb4b9a3d5c305f93d3cfd0eddffa30588=
4597f
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 19 Dec 2025 16:40:16 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 16:43:34 +01:00

MAINTAINERS: Add entry for Context Analysis

Add entry for all new files added for Clang's context analysis.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20251219154418.3592607-28-elver@google.com
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b11839..2953b46 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6132,6 +6132,17 @@ M:	Nelson Escobar <neescoba@cisco.com>
 S:	Supported
 F:	drivers/infiniband/hw/usnic/
=20
+CLANG CONTEXT ANALYSIS
+M:	Marco Elver <elver@google.com>
+R:	Bart Van Assche <bvanassche@acm.org>
+L:	llvm@lists.linux.dev
+S:	Maintained
+F:	Documentation/dev-tools/context-analysis.rst
+F:	include/linux/compiler-context-analysis.h
+F:	lib/test_context-analysis.c
+F:	scripts/Makefile.context-analysis
+F:	scripts/context-analysis-suppression.txt
+
 CLANG CONTROL FLOW INTEGRITY SUPPORT
 M:	Sami Tolvanen <samitolvanen@google.com>
 M:	Kees Cook <kees@kernel.org>

