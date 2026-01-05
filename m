Return-Path: <linux-tip-commits+bounces-7817-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6DFCF49B3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 17:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B4FA301956D
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 16:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9614D2D5C71;
	Mon,  5 Jan 2026 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dy598xjg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="frb3My2m"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C724B349B0F;
	Mon,  5 Jan 2026 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628491; cv=none; b=QHCJfwrDsquopFVB2ADUmZI5q/8cHrmfGT76iUn6/9r63pPvhgk3u6DExYtGcU/6hgCG4jPMXvDOlLjhqeNAA5e6xJVfnkjWXO/StAshWUrCPY/R66UKfz4/neU5yEwQiPEs+jF8l+FHNsoUnbs9d6NIpwczgVIf4RsiuZ69tsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628491; c=relaxed/simple;
	bh=Ndks3WW3fndhO0l8MstUabQe4EY3nozT4VhP/ZUF1CY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RgYUByQHl4fQW5PFgwqPlS7e8UF+lbSVt2ljQaYWUEQkfePvNjKssDPEnniVLo6+lSOWT4JOYdbC4mp/sspr3dM3oL7R60x07/Y7+3ti+hkj91zG+KA7/rDJpthRP0CitkfwHOBDLrJ0cDL1aiQtKzWl58qASgUMzZN4IriLdX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dy598xjg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=frb3My2m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:54:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767628484;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gxkMC0xJO3fKyLwwtBIdlqb9vMGxnFSsWP3FRFm16Y0=;
	b=Dy598xjgGFy3vF1TILm4ZPcclSg0ZUK15BNztEC3HtxJMETMpcMgW8wv0c6oBPAjWLNDZO
	9A/gKSr/PwZ2lzNABcoYtRF5mYLX+QhZhJWldxQXaC1rc5T84LoWZRsEOA5lAuFphIthpf
	ONXSkMLcP305ZwYz1LejKmAk6Lwfll9YcYn8ciq13aTeLtiA87xyjPK+oQ6mZWCXgAcpcG
	V3cbDwgo7CJAphg4fQ2QfszQbpCfgsiZ/G/PHFxQRv/dbx51az91eqrbezuQrViYGnq2kV
	8lAMk8XSoAoJZtM0FrNZE44zulrHB2He5EG3ScPVMzoUUQ9IyAP1L3NurX5crA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767628484;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gxkMC0xJO3fKyLwwtBIdlqb9vMGxnFSsWP3FRFm16Y0=;
	b=frb3My2mTZ6PShfNRzxBbuzLE8EPII7AngigGsFtmgqYKZbkc+E3NzFB5vo2/QYcSiXA+P
	ItDcHKoDSZOK2gCA==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] checkpatch: Warn about context_unsafe() without comment
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251219154418.3592607-6-elver@google.com>
References: <20251219154418.3592607-6-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762848306.510.625133126924900172.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     25d3b21e1d41f7b58aeb62b97b05d86d43c91801
Gitweb:        https://git.kernel.org/tip/25d3b21e1d41f7b58aeb62b97b05d86d43c=
91801
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 19 Dec 2025 16:39:54 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 16:43:27 +01:00

checkpatch: Warn about context_unsafe() without comment

Warn about applications of context_unsafe() without a comment, to
encourage documenting the reasoning behind why it was deemed safe.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251219154418.3592607-6-elver@google.com
---
 scripts/checkpatch.pl | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c025024..c4fd8bd 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6733,6 +6733,13 @@ sub process {
 			}
 		}
=20
+# check for context_unsafe without a comment.
+		if ($line =3D~ /\bcontext_unsafe\b/ &&
+		    !ctx_has_comment($first_line, $linenr)) {
+			WARN("CONTEXT_UNSAFE",
+			     "context_unsafe without comment\n" . $herecurr);
+		}
+
 # check of hardware specific defines
 		if ($line =3D~ m@^.\s*\#\s*if.*\b(__i386__|__powerpc64__|__sun__|__s390x__=
)\b@ && $realfile !~ m@include/asm-@) {
 			CHK("ARCH_DEFINES",

