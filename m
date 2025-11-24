Return-Path: <linux-tip-commits+bounces-7492-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1524BC7F843
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 10:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D8F3348D77
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 09:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F412FB62C;
	Mon, 24 Nov 2025 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aGL9lC/u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="48BLxIYw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF102F9DA0;
	Mon, 24 Nov 2025 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975512; cv=none; b=c8bBBst8V4MZrPHVRHDED6HaerLWexGpLgFtrKUPG1ckJaxw1U68S15t4pFDEB2BCzWadVGG16un6UaXIdNxndHwuTrf7904OTfM+zH/uAKDbkb5eXAmYHr5ME3dlDAOcedCHHD/UvRcOCsuJjbqgNLr/HdbIaOdfooJXH8j/A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975512; c=relaxed/simple;
	bh=++LOiqNpC44mbd66FOy6biDjvlUa+u6+/t1Rs2oxoMk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lNX6RRT1u0Nv1lKbvc43d+n5PJMIcMXlqRuZscT+WVVFEDOf3IoxsSu0D/DfiVsgOCQhzlRwCMwkzqPaXAhzmpWoZ9fgS3dNFZYIyzlOrf5NiW1MMxebCL04O2C9RtjouROFBzTeGQUN6sraEqB9buQABaRtaWEzOQJ12dUpBgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aGL9lC/u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=48BLxIYw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 09:11:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763975509;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cmKHZBIE1ttpeyPwpC8ZmBdOAlIOPjXXstWQ+LGo83k=;
	b=aGL9lC/ugSby9uTySC+sL8IJl/0oPHWlHX2rp+t5NlLrNszHMo9FfGmoJezcHYYMrGsQVQ
	gUP9S1DP6vUtKsxFKAqhsCfQt89M/ctnQbQCe1wcGOWMPam6/p5CJpOBrTuHQNrBVbdmlj
	WCVQuPryiUiPFVzkdDKrQCZRtWSg2plvJYLIehAw+6lUUxVudGsBMlDTNTZswqfSqeV0i7
	fSrlYpWXNAS4q+3++pVuuJkXxFPdnHvPFS+pQm4GuZOoA4Jtpx/BWDrf2Lap4NCqEpNA/7
	XDgTQXwATFpn2IZK+OPVnDAI7V20J3QdCqdGdFhU8fYjW4m0Bh62EirpXeN+Gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763975509;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cmKHZBIE1ttpeyPwpC8ZmBdOAlIOPjXXstWQ+LGo83k=;
	b=48BLxIYwGl8pPr47jiZNJYWuGObOHIkGkg6lRBXRUX5L4PZu7H0MxKQ9AEg+ITPJMGt1ic
	9DCHQIzv469NwfBw==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Do not validate IBT for .return_sites
 and .call_sites
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251121095340.464045-17-alexandre.chartre@oracle.com>
References: <20251121095340.464045-17-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176397550799.498.17947549306101322103.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     c3b7d044fc5ac99a31ce9420431b90e21ed55503
Gitweb:        https://git.kernel.org/tip/c3b7d044fc5ac99a31ce9420431b90e21ed=
55503
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:26 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 15:30:12 +01:00

objtool: Do not validate IBT for .return_sites and .call_sites

The .return_sites and .call_sites sections reference text addresses,
but not with the intent to indirect branch to them, so they don't
need to be validated for IBT.

This is useful when running objtool on object files which already
have .return_sites or .call_sites sections, for example to re-run
objtool after it has reported an error or a warning.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/20251121095340.464045-17-alexandre.chartre@ora=
cle.com
---
 tools/objtool/check.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 442b655..4ebadf9 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4753,6 +4753,8 @@ static int validate_ibt(struct objtool_file *file)
 		    !strcmp(sec->name, ".llvm.call-graph-profile")	||
 		    !strcmp(sec->name, ".llvm_bb_addr_map")		||
 		    !strcmp(sec->name, "__tracepoints")			||
+		    !strcmp(sec->name, ".return_sites")			||
+		    !strcmp(sec->name, ".call_sites")			||
 		    !strcmp(sec->name, "__patchable_function_entries"))
 			continue;
=20

