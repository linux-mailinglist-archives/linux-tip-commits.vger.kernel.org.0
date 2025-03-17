Return-Path: <linux-tip-commits+bounces-4288-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 510C9A64CE5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 12:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5294169C01
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E3C1474DA;
	Mon, 17 Mar 2025 11:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aalPKhNF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qMXRRaqW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8FF199E8D;
	Mon, 17 Mar 2025 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742211448; cv=none; b=idrwKCj+TWMxmGYQ3Q5qveGe/GLsJjTrtbpjTGDs6h6xVssUcXLX/MAy2gN7niyEm7pl0IRxZlExeJqwNgoth5NRNZD6Y3eIzyVWVjG348LTsk9mieJgp/FPaHHID51/1k4H3gvvJe8IQ8QolOf5smL6NixwEUG/X0hMB+naXfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742211448; c=relaxed/simple;
	bh=71CXXVtgzmlwAMwzcr5G9y1vpDB4nXN8Vvsor8sLpO8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=V/mPFVg8pGGtKRhDX6XNCtpv2A8MNWzcNK30KOYN2bevIibHAHuQaMabJJzrg9k5VqI5SDc0cW1uPaH6/4VPXhkwkIcimyMjUWd9FPWLcDNiCSIc3eDdXqWTKQyhxe9mU/QC9R8hfrCx6wI7o9dCfqYBxUcRMEC5y9JPrZNrIZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aalPKhNF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qMXRRaqW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 11:37:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742211444;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=3HSqls5wrVuDhzHqTP6Wk1iiOHTNEb5g1Pk7dwr89RQ=;
	b=aalPKhNFrw84QFhv7i4MGrxJ6rG/HATqbd6kN+xskv76puwSJHYGxbrr9NMxu8DP+99nae
	+r9RdDKvQ1O+8B0HNXFEPUL7UUQd29fOURzl4/Zd2M0S9xck8LkCqau45bQ7bCt5Z7FNEY
	iish/+XKz7RDzFmhHnefNbooCB7TxlGSYjlPoTcvy/+CZtBIdUFAsrLIz2n7fIEWtfqck0
	S1LNSf/Bxx+licJ8JKWDYg7BKZkaCwThjNYcOaFkCUDmeeHwy2LlMbb+NbT/5Mj6s+laxa
	0NLEZMitQVgiKPorHaA703k+E4gm030yJ0uLSzOMbtc2JAVkS/ojZSH5s3xYYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742211444;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=3HSqls5wrVuDhzHqTP6Wk1iiOHTNEb5g1Pk7dwr89RQ=;
	b=qMXRRaqWuxKiEbp7N4DYmEMG63+Hdjzpx5s2FYgLSsk69NwCMA/Hljbg93iT5XnriA6Q0B
	slhdEvB9Cat35pDg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Use O_CREAT with explicit mode mask
Cc: Ingo Molnar <mingo@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174221144059.14745.8349031235521776012.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     73070466ed3b5e4620e03c159ee12a570b171d08
Gitweb:        https://git.kernel.org/tip/73070466ed3b5e4620e03c159ee12a570b1=
71d08
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 17 Mar 2025 12:21:57 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 17 Mar 2025 12:24:02 +01:00

objtool: Use O_CREAT with explicit mode mask

Recent Ubuntu enforces 3-argument open() with O_CREAT:

      CC      /home/mingo/tip/tools/objtool/builtin-check.o
    In file included from /usr/include/fcntl.h:341,
                     from builtin-check.c:9:
    In function =E2=80=98open=E2=80=99,
        inlined from =E2=80=98copy_file=E2=80=99 at builtin-check.c:201:11:
    /usr/include/x86_64-linux-gnu/bits/fcntl2.h:52:11: error: call to =E2=80=
=98__open_missing_mode=E2=80=99 declared with attribute error: open with O_CR=
EAT or O_TMPFILE in second argument needs 3 arguments
       52 |           __open_missing_mode ();
          |           ^~~~~~~~~~~~~~~~~~~~~~

Use 0400 as the most restrictive mode for the new file.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
---
 tools/objtool/builtin-check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 39ddca6..5f761f4 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -198,7 +198,7 @@ static int copy_file(const char *src, const char *dst)
 		return 1;
 	}
=20
-	dst_fd =3D open(dst, O_WRONLY | O_CREAT | O_TRUNC);
+	dst_fd =3D open(dst, O_WRONLY | O_CREAT | O_TRUNC, 0400);
 	if (dst_fd =3D=3D -1) {
 		ERROR("can't open '%s' for writing", dst);
 		return 1;

