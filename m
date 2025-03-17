Return-Path: <linux-tip-commits+bounces-4273-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 509BCA64AA9
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A09B1188636A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F42E2356AA;
	Mon, 17 Mar 2025 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EKkj/iIk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="faVBFcMn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02773219301;
	Mon, 17 Mar 2025 10:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208390; cv=none; b=ZztWT9vOlaRSbCwLnPpZpB5WUmNcOWPZJ1G7oyw+ylzGB/1eoaQl+SeryBzRi/K3FNkbxJtf/3X83sEuYbJPFOF7k7Bv4iLgC9MuKuaqhfKrwq0f7iFNlTZcSooidStHKjvkMCQZbHjc1dv7kdpsGcHWDWg8Q7HjtACkzK5N4ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208390; c=relaxed/simple;
	bh=E2ZsEza58MCCwYGHHMeocjIojzgSWQfzCRb0qJ15128=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MlJzgwTeKK4FAEifB2SA1/CyqFoGJXKan3a+5PCA28tcN0zkRhrNtqaQFcsYpIlwUj8J2aGD3cNLuDtgl/Xp/8LMQkWR95Fbjmi2GoSCZhVyqdOHMLG4hiMIU0pKBhuwX5Hc+6e9XM9+F806pcAJ5dYMw2Ma8H6UxSkD/qy2slo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EKkj/iIk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=faVBFcMn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:46:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742208386;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iuBC1KwXb6H4RgZJPBx6mRAYWZASgB532UX/SNLfTUg=;
	b=EKkj/iIkRihIBS02gWd/Qsn5NmD7Qcrr6CQZr2RUv2pDGsppEI9mPAPJIffPmLKbCA6SW3
	McxpePbcpFPTZEq8r9Vfox+Vokjhu8SNey/COE2cHKQp4C5QnwFBK7nlURQbmCb1a2peGX
	eKxwPxlLa49syE2c2Ia77ISgjx2xDDoig0aWgomENPgIZ4adQVK3x2ehVBO5A5eip8eMkk
	UbEMfrk8NKqepSCp3Mn2unMZifquvD+X+AdvVfNz1/bm9dJf6OOWRQ6SQ4ncL6ipgnsHeP
	nPVxlC3Qv0IZmrCXmgRqNwGHgjX9xd3U4qsFDT+gtcrGGkYRyghGD6xRQFFbLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742208386;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iuBC1KwXb6H4RgZJPBx6mRAYWZASgB532UX/SNLfTUg=;
	b=faVBFcMnHD2Bpt6rXcrtWs3l4p2GpGof2DyoAH3+qJFuEYIux1a2otH+iCrmtbJR3ny1XH
	M8HWkSmTMcqFQjDw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool: Change "warning:" to "error:" for --Werror
Cc: Nathan Chancellor <nathan@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Brendan Jackman <jackmanb@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <56f0565b15b4b4caa9a08953fa9c679dfa973514.1741975349.git.jpoimboe@kernel.org>
References:
 <56f0565b15b4b4caa9a08953fa9c679dfa973514.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220838596.14745.7784753134023257234.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     a307dd28b1c6655b67b2367663331034ac8da79c
Gitweb:        https://git.kernel.org/tip/a307dd28b1c6655b67b2367663331034ac8da79c
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 14 Mar 2025 12:29:09 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:36:02 +01:00

objtool: Change "warning:" to "error:" for --Werror

This is similar to GCC's behavior and makes it more obvious why the
build failed.

Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Link: https://lore.kernel.org/r/56f0565b15b4b4caa9a08953fa9c679dfa973514.1741975349.git.jpoimboe@kernel.org
---
 tools/objtool/include/objtool/warn.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
index 6180288..e72b9d6 100644
--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -43,8 +43,10 @@ static inline char *offstr(struct section *sec, unsigned long offset)
 
 #define WARN(format, ...)				\
 	fprintf(stderr,					\
-		"%s: warning: objtool: " format "\n",	\
-		objname, ##__VA_ARGS__)
+		"%s: %s: objtool: " format "\n",	\
+		objname,				\
+		opts.werror ? "error" : "warning",	\
+		##__VA_ARGS__)
 
 #define WARN_FUNC(format, sec, offset, ...)		\
 ({							\

