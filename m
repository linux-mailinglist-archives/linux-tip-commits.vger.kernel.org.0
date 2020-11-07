Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D4B2AA622
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Nov 2020 16:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgKGPOB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 7 Nov 2020 10:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgKGPOA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 7 Nov 2020 10:14:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061A6C0613CF;
        Sat,  7 Nov 2020 07:14:00 -0800 (PST)
Date:   Sat, 07 Nov 2020 15:13:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604762038;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0PQvG1NGlsUmpy3PYhdoQOlMa3vgrITh63EU5xW+bVw=;
        b=I96M6/hhTPWh/28YnHMFa5TLIi37rlzuLeEghephTMnXCZxxlUkRNWm1oCD1p9Lf19YOIR
        4BVCdzKd3yUYp/AAZcD99yDi/td9tWOJ9jVFXGRz0XOcHxnTweLXkTt1p2F8VSlpyWcu8e
        fz3XlPL/TaugEWw4+Auv7a5f2gflvCJiWZRGx/Oyv2zRWK4xcYYf4HtXtAPUIr0ibpK+63
        +Co8Nog+zQqchrPkxoG0yWe1t211QnLxXh/cBlrcwSSd269fhoLCQOKwAmEeunAkqYR495
        WTy/ZGzVaopT8umd0duGmMiUIAfaZG7fwGI/ISZ1meJRyecpDCoe/+bk7I3HZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604762038;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0PQvG1NGlsUmpy3PYhdoQOlMa3vgrITh63EU5xW+bVw=;
        b=B5ClDqhkZdndPCW8+keEsaQhWmnCy943Nq3hBIcr2ykhHRt456OgyLldtL9qo1pEmTECfS
        n3vcP0oZUTEADOCA==
From:   tip-bot2 for =?utf-8?b?a2l5aW4o5bC55LquKQ==?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Fix a memory leak in
 perf_event_parse_addr_filter()
Cc:     kiyin@tencent.com, Dan Carpenter <dan.carpenter@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Anthony Liguori <aliguori@amazon.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160476203763.11244.1944858021967804200.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     7bdb157cdebbf95a1cd94ed2e01b338714075d00
Gitweb:        https://git.kernel.org/tip/7bdb157cdebbf95a1cd94ed2e01b3387140=
75d00
Author:        kiyin(=E5=B0=B9=E4=BA=AE) <kiyin@tencent.com>
AuthorDate:    Wed, 04 Nov 2020 08:23:22 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 07 Nov 2020 13:07:26 +01:00

perf/core: Fix a memory leak in perf_event_parse_addr_filter()

As shown through runtime testing, the "filename" allocation is not
always freed in perf_event_parse_addr_filter().

There are three possible ways that this could happen:

 - It could be allocated twice on subsequent iterations through the loop,
 - or leaked on the success path,
 - or on the failure path.

Clean up the code flow to make it obvious that 'filename' is always
freed in the reallocation path and in the two return paths as well.

We rely on the fact that kfree(NULL) is NOP and filename is initialized
with NULL.

This fixes the leak. No other side effects expected.

[ Dan Carpenter: cleaned up the code flow & added a changelog. ]
[ Ingo Molnar: updated the changelog some more. ]

Fixes: 375637bc5249 ("perf/core: Introduce address range filtering")
Signed-off-by: "kiyin(=E5=B0=B9=E4=BA=AE)" <kiyin@tencent.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Cc: Anthony Liguori <aliguori@amazon.com>
--
 kernel/events/core.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)
---
 kernel/events/core.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index da467e1..5a29ab0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10085,6 +10085,7 @@ perf_event_parse_addr_filter(struct perf_event *event=
, char *fstr,
 			if (token =3D=3D IF_SRC_FILE || token =3D=3D IF_SRC_FILEADDR) {
 				int fpos =3D token =3D=3D IF_SRC_FILE ? 2 : 1;
=20
+				kfree(filename);
 				filename =3D match_strdup(&args[fpos]);
 				if (!filename) {
 					ret =3D -ENOMEM;
@@ -10131,16 +10132,13 @@ perf_event_parse_addr_filter(struct perf_event *eve=
nt, char *fstr,
 				 */
 				ret =3D -EOPNOTSUPP;
 				if (!event->ctx->task)
-					goto fail_free_name;
+					goto fail;
=20
 				/* look up the path and grab its inode */
 				ret =3D kern_path(filename, LOOKUP_FOLLOW,
 						&filter->path);
 				if (ret)
-					goto fail_free_name;
-
-				kfree(filename);
-				filename =3D NULL;
+					goto fail;
=20
 				ret =3D -EINVAL;
 				if (!filter->path.dentry ||
@@ -10160,13 +10158,13 @@ perf_event_parse_addr_filter(struct perf_event *eve=
nt, char *fstr,
 	if (state !=3D IF_STATE_ACTION)
 		goto fail;
=20
+	kfree(filename);
 	kfree(orig);
=20
 	return 0;
=20
-fail_free_name:
-	kfree(filename);
 fail:
+	kfree(filename);
 	free_filters_list(filters);
 	kfree(orig);
=20
