Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061534278AD
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 12:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbhJIKJF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 06:09:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49368 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244458AbhJIKJC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 06:09:02 -0400
Date:   Sat, 09 Oct 2021 10:07:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633774024;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5cTB2auWBZmBd2mNztBvTP0wojwUG+HZ7bx051kXEeQ=;
        b=3DDlFXmUfdNzoCWQa9EDocB+04+/NxnCeOgOw2V5PxPYT+myq4QcvS9d6lsIWlb1dJMlD7
        e9nFq6LQsvBtTk9Ajfi+QQ94lXNkCgjD7JVm2dhAZMMgviW/ZDPgbMrIYbN7IVJ5cumdwN
        EOx4OgC51AQRr+nYCTjTWjumhptX4VRCqN9Ykb+ynRrZnq8s21cJRo98YdBvq9Gid+8wr3
        jA0JDJ3CNTo0sggx1ZiqmlWh2wkhChJQW9chu/+yO28YIh4+ubGXhwECRY8kJpwx5H/I9N
        ygXhuzhGq8VmeSV9mkWx7dP9z6vtaOnrVRtgxanBi4pSlZvSXsxMycjsZuOpww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633774024;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5cTB2auWBZmBd2mNztBvTP0wojwUG+HZ7bx051kXEeQ=;
        b=v1jpfHWoiFmP7H4R+IpXxust2S91yPJ+CCHnCc5OhlMuLF8/FaX0Ud/PkLGhJA3qZdCQda
        eEULVjyaNz71miDg==
From:   tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex,x86: Wire up sys_futex_waitv()
Cc:     andrealmeid@collabora.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210923171111.300673-18-andrealmeid@collabora.com>
References: <20210923171111.300673-18-andrealmeid@collabora.com>
MIME-Version: 1.0
Message-ID: <163377402375.25758.9889603236769021.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     039c0ec9bb77446d7ada7f55f90af9299b28ca49
Gitweb:        https://git.kernel.org/tip/039c0ec9bb77446d7ada7f55f90af9299b2=
8ca49
Author:        Andr=C3=A9 Almeida <andrealmeid@collabora.com>
AuthorDate:    Thu, 23 Sep 2021 14:11:06 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Oct 2021 13:51:11 +02:00

futex,x86: Wire up sys_futex_waitv()

Wire up syscall entry point for x86 arch, for both i386 and x86_64.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210923171111.300673-18-andrealmeid@collabor=
a.com
---
 arch/x86/entry/syscalls/syscall_32.tbl | 1 +
 arch/x86/entry/syscalls/syscall_64.tbl | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls=
/syscall_32.tbl
index 960a021..7e25543 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -453,3 +453,4 @@
 446	i386	landlock_restrict_self	sys_landlock_restrict_self
 447	i386	memfd_secret		sys_memfd_secret
 448	i386	process_mrelease	sys_process_mrelease
+449	i386	futex_waitv		sys_futex_waitv
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls=
/syscall_64.tbl
index 18b5500..fe8f8dd 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -370,6 +370,7 @@
 446	common	landlock_restrict_self	sys_landlock_restrict_self
 447	common	memfd_secret		sys_memfd_secret
 448	common	process_mrelease	sys_process_mrelease
+449	common	futex_waitv		sys_futex_waitv
=20
 #
 # Due to a historical design error, certain syscalls are numbered differently
