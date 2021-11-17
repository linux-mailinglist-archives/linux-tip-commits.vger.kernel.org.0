Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076CF45493F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Nov 2021 15:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhKQOzC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Nov 2021 09:55:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60398 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbhKQOy6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Nov 2021 09:54:58 -0500
Date:   Wed, 17 Nov 2021 14:51:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637160718;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Z39UcslXnmosc0Rg0xECpGYLAgsrv7cYapEjCFYu3g=;
        b=ENldEUDp1OsQYRlrv4Jz6hf8Xo2mZWs4CGdz7ETYNnlOBMxUgY8h8fO+wNoeSxv22Ts4kC
        Bo/EIMt0GwdB3aFQLexHcqD/aeIc3TPwaDtuew/bdR4qyTqShAeO069QICxWccbFgfAgQM
        RXMP8ehc8pnACU8cYopGkaNBhNjGEh/dTSnNWsPLIoriZDLV3BgVwl7JGfboHcX+cOrytx
        GjgjzOgrhoH+yDppUFRPRzD3995lZlv/0Vfp7d92PzAEoaH/tHTsaa1fxSEt1PeqR3FuL7
        fFhkHnsuBMpGhAUihXY6LLT1ZDzkYvUWt4YfrKnyx419W+EhUJ2rmJf3GloH6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637160718;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Z39UcslXnmosc0Rg0xECpGYLAgsrv7cYapEjCFYu3g=;
        b=2GCX7/EnpdwBQK14SwpVfGCVgyqaIKCriSabCUv7ln/h76R0vcDuCzPvayB0GILLxj2n/p
        ZvTifNOR0n5yUdBg==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Fix minor documentation issues
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cab99a87368eef69e3fb96f073368becff3eff874=2E16355?=
 =?utf-8?q?29506=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3Cab99a87368eef69e3fb96f073368becff3eff874=2E163552?=
 =?utf-8?q?9506=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <163716071746.11128.8446441679647063855.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     379e4de9e140850cf699dd390f21ea4b923c955d
Gitweb:        https://git.kernel.org/tip/379e4de9e140850cf699dd390f21ea4b923=
c955d
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Fri, 29 Oct 2021 10:49:56 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 17 Nov 2021 06:36:09 -08:00

x86/sgx: Fix minor documentation issues

The SGX documentation has a few repeated or one-off issues:

 * Remove capitalization from regular words in the middle of a sentence.
 * Remove punctuation found in the middle of a sentence.
 * Fix name of SGX daemon to consistently be ksgxd.
 * Fix typo of SGX instruction: ENIT -> EINIT

[ dhansen: tweaked subject and changelog ]

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/ab99a87368eef69e3fb96f073368becff3eff874.1635=
529506.git.reinette.chatre@intel.com
---
 Documentation/x86/sgx.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
index a608f66..265568a 100644
--- a/Documentation/x86/sgx.rst
+++ b/Documentation/x86/sgx.rst
@@ -10,7 +10,7 @@ Overview
 Software Guard eXtensions (SGX) hardware enables for user space applications
 to set aside private memory regions of code and data:
=20
-* Privileged (ring-0) ENCLS functions orchestrate the construction of the.
+* Privileged (ring-0) ENCLS functions orchestrate the construction of the
   regions.
 * Unprivileged (ring-3) ENCLU functions allow an application to enter and
   execute inside the regions.
@@ -91,7 +91,7 @@ In addition to the traditional compiler and linker build pr=
ocess, SGX has a
 separate enclave =E2=80=9Cbuild=E2=80=9D process.  Enclaves must be built be=
fore they can be
 executed (entered). The first step in building an enclave is opening the
 **/dev/sgx_enclave** device.  Since enclave memory is protected from direct
-access, special privileged instructions are Then used to copy data into encl=
ave
+access, special privileged instructions are then used to copy data into encl=
ave
 pages and establish enclave page permissions.
=20
 .. kernel-doc:: arch/x86/kernel/cpu/sgx/ioctl.c
@@ -126,13 +126,13 @@ the need to juggle signal handlers.
 ksgxd
 =3D=3D=3D=3D=3D
=20
-SGX support includes a kernel thread called *ksgxwapd*.
+SGX support includes a kernel thread called *ksgxd*.
=20
 EPC sanitization
 ----------------
=20
 ksgxd is started when SGX initializes.  Enclave memory is typically ready
-For use when the processor powers on or resets.  However, if SGX has been in
+for use when the processor powers on or resets.  However, if SGX has been in
 use since the reset, enclave pages may be in an inconsistent state.  This mi=
ght
 occur after a crash and kexec() cycle, for instance.  At boot, ksgxd
 reinitializes all enclave pages so that they can be allocated and re-used.
@@ -147,7 +147,7 @@ Page reclaimer
=20
 Similar to the core kswapd, ksgxd, is responsible for managing the
 overcommitment of enclave memory.  If the system runs out of enclave memory,
-*ksgxwapd* =E2=80=9Cswaps=E2=80=9D enclave memory to normal memory.
+*ksgxd* =E2=80=9Cswaps=E2=80=9D enclave memory to normal memory.
=20
 Launch Control
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -156,7 +156,7 @@ SGX provides a launch control mechanism. After all enclav=
e pages have been
 copied, kernel executes EINIT function, which initializes the enclave. Only =
after
 this the CPU can execute inside the enclave.
=20
-ENIT function takes an RSA-3072 signature of the enclave measurement.  The f=
unction
+EINIT function takes an RSA-3072 signature of the enclave measurement.  The =
function
 checks that the measurement is correct and signature is signed with the key
 hashed to the four **IA32_SGXLEPUBKEYHASH{0, 1, 2, 3}** MSRs representing the
 SHA256 of a public key.
@@ -184,7 +184,7 @@ CPUs starting from Icelake use Total Memory Encryption (T=
ME) in the place of
 MEE. TME-based SGX implementations do not have an integrity Merkle tree, whi=
ch
 means integrity and replay-attacks are not mitigated.  B, it includes
 additional changes to prevent cipher text from being returned and SW memory
-aliases from being Created.
+aliases from being created.
=20
 DMA to enclave memory is blocked by range registers on both MEE and TME syst=
ems
 (SDM section 41.10).
