Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC73433AA6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Oct 2021 17:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhJSPhy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 19 Oct 2021 11:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbhJSPhx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 19 Oct 2021 11:37:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E197EC06161C;
        Tue, 19 Oct 2021 08:35:40 -0700 (PDT)
Date:   Tue, 19 Oct 2021 15:35:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634657739;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9WgLi00AcF9O/IH2/ZzWbvDIXR7rXtXhUwwydZmm1vE=;
        b=C1sY89aP2HWdJQMa32rJtmKb1ysAiCk+XXqLO25zEla6O01v09sbz3S4Qq8DTZeNC2Rwd2
        SjIrEynheX9unPVhabVGIzTMSBeXPmwiImtt56QKXe6B4CRcrF5aUOPAG/EEUeOACV49GI
        5FYPvvBgSLTqYXIU3PcGk1+kVHaIt9mDPey/fsWBp10lwDyGrTWYAfSwm+KOhcrMoAp2Hd
        cOemF3QJg3HnYzlIzA3G9CkVhGpCJczvbNNtixZo6tNx9Ew8heVYnXJkbxtBfuGREqL7FI
        EByNnJJpWM5aSoYSHpbuBy7n7zfW7bQoZR/lXMdH3XsB7lQR8BRY4YLZUiCMQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634657739;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9WgLi00AcF9O/IH2/ZzWbvDIXR7rXtXhUwwydZmm1vE=;
        b=btOjzdYSHDK7rYf+OdZ97BS2SfFjw70o8+AK80a8LXYnif7XqlrZihT1KT7z75edJKiUkY
        hMJg4IIlo6AVabAw==
From:   tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] docs: futex: Fix kernel-doc references
Cc:     andrealmeid@collabora.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211012135549.14451-1-andrealmeid@collabora.com>
References: <20211012135549.14451-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Message-ID: <163465773865.25758.1351829180752520618.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     bc67f1c454fbc79b148f0b47227929da82f4b026
Gitweb:        https://git.kernel.org/tip/bc67f1c454fbc79b148f0b47227929da82f=
4b026
Author:        Andr=C3=A9 Almeida <andrealmeid@collabora.com>
AuthorDate:    Tue, 12 Oct 2021 10:55:49 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Oct 2021 17:27:05 +02:00

docs: futex: Fix kernel-doc references

Since the futex code was restructured, there's no futex.c file anymore
and the implementation is split in various files. Point kernel-doc
references to the new files.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211012135549.14451-1-andrealmeid@collabora.=
com
---
 Documentation/kernel-hacking/locking.rst                    | 14 ++++++-
 Documentation/translations/it_IT/kernel-hacking/locking.rst | 14 ++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-=
hacking/locking.rst
index 90bc3f5..e6cd406 100644
--- a/Documentation/kernel-hacking/locking.rst
+++ b/Documentation/kernel-hacking/locking.rst
@@ -1352,7 +1352,19 @@ Mutex API reference
 Futex API reference
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-.. kernel-doc:: kernel/futex.c
+.. kernel-doc:: kernel/futex/core.c
+   :internal:
+
+.. kernel-doc:: kernel/futex/futex.h
+   :internal:
+
+.. kernel-doc:: kernel/futex/pi.c
+   :internal:
+
+.. kernel-doc:: kernel/futex/requeue.c
+   :internal:
+
+.. kernel-doc:: kernel/futex/waitwake.c
    :internal:
=20
 Further reading
diff --git a/Documentation/translations/it_IT/kernel-hacking/locking.rst b/Do=
cumentation/translations/it_IT/kernel-hacking/locking.rst
index 1efb829..163f1bd 100644
--- a/Documentation/translations/it_IT/kernel-hacking/locking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/locking.rst
@@ -1396,7 +1396,19 @@ Riferimento per l'API dei Mutex
 Riferimento per l'API dei Futex
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
=20
-.. kernel-doc:: kernel/futex.c
+.. kernel-doc:: kernel/futex/core.c
+   :internal:
+
+.. kernel-doc:: kernel/futex/futex.h
+   :internal:
+
+.. kernel-doc:: kernel/futex/pi.c
+   :internal:
+
+.. kernel-doc:: kernel/futex/requeue.c
+   :internal:
+
+.. kernel-doc:: kernel/futex/waitwake.c
    :internal:
=20
 Approfondimenti
