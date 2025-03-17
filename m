Return-Path: <linux-tip-commits+bounces-4276-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3B6A64AAF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8A71886436
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E30523716E;
	Mon, 17 Mar 2025 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RfkqDZBZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NzrYiFsa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70BA2356BF;
	Mon, 17 Mar 2025 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208392; cv=none; b=JRjWox+OgqD6UiJfhaOm76DT+A3t+yKhW9F6DPFp2NMqDGphFGRyf7F643Nbe7zIFBIXey05ZLDAAOGQjn66khyensSMmqIngxi09LKXJ6FXumRBKs8kGPFFG5POUHUmc9ahd5oJZ7VufPcG6pcoiGSPHfy8w+Jl8jfPkTFUvS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208392; c=relaxed/simple;
	bh=GCSoHkXlZ2kpvtqK3H4903D9rdJilmwtxqAHChQ1lwI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PU8jH3cbFVdDrWI8qQQH8dVYyvfY/dYkSvVO9Fn6/ACrmoRUEjdILxyxNF4ZuIVs4MdZWut+8c9TFsCK4cljhE0Lrmn2No74E3lMnwJ0OP880qfXhramUCMJiswhxmOkQVpIY8s7z/nGmKIvcxTaNw8ZcUFBZ8rRCn+nQB+NUtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RfkqDZBZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NzrYiFsa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:46:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742208388;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EWJnEUZW1AM/Ytc/TZ6qWdyFlUZYOnCWGQA+hgCdL/g=;
	b=RfkqDZBZ6D/G02ve64VyKDrZWNdEZg5IQooHhPXAOrmhLqw7NNoCxwBPa8gYz/3vBx+8/N
	WES0q8TYR+L1dyjC21c1/WHsTCHUQxfPTdkzX870HMobQul9u4dPfBlF6fsw6PgJiqZZTd
	8jqI2Bz78NJsLXlahpNxaEOYl4oC5NVZNgoja7h3sL17NQ6FCaJ0F78bpNnf6Gd0NRm6/q
	EV4WbJC1PRMRN4E/sscFXE84LipkENb+MxP+6hhpdGUY2Hx7ceZPO7DNsGYYApXhfcUadK
	i7XhveUNVf3+wK8muP5f1P8gw8lAb2UP1ZUjNSTUPOevsx5HrPW4rGqKo+uimg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742208388;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EWJnEUZW1AM/Ytc/TZ6qWdyFlUZYOnCWGQA+hgCdL/g=;
	b=NzrYiFsakJDVpwQZE1sUYHl/c4SjftOPBeamRDEWt/jsiHLKy9SAgclRwrtjQjx0F1C2S8
	rFY0HSTzZKqMaiDA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Upgrade "Linked object detected" warning
 to error
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Brendan Jackman <jackmanb@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <8380bbf3a0fa86e03fd63f60568ae06a48146bc1.1741975349.git.jpoimboe@kernel.org>
References:
 <8380bbf3a0fa86e03fd63f60568ae06a48146bc1.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220838805.14745.15531789237557313857.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     fdf5ff2934f4c5c6b483c906fea6e0288df36da2
Gitweb:        https://git.kernel.org/tip/fdf5ff2934f4c5c6b483c906fea6e0288df36da2
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 14 Mar 2025 12:29:06 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:36:01 +01:00

objtool: Upgrade "Linked object detected" warning to error

Force the user to fix their cmdline if they forget the '--link' option.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Link: https://lore.kernel.org/r/8380bbf3a0fa86e03fd63f60568ae06a48146bc1.1741975349.git.jpoimboe@kernel.org
---
 tools/objtool/builtin-check.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 36d81a4..7984351 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -198,8 +198,8 @@ int objtool_run(int argc, const char **argv)
 		return 1;
 
 	if (!opts.link && has_multiple_files(file->elf)) {
-		ERROR("Linked object detected, forcing --link");
-		opts.link = true;
+		ERROR("Linked object requires --link");
+		goto err;
 	}
 
 	ret = check(file);

