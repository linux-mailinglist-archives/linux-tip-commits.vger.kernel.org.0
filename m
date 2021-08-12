Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E62D3EA79A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 12 Aug 2021 17:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237991AbhHLPbi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 12 Aug 2021 11:31:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:42799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237922AbhHLPbi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 12 Aug 2021 11:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628782265;
        bh=/Gr1GdWHDT8BPNnA+VcX8W7t9qtsbNmaU/ibJFzxrAw=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=RehEff0aaD4fYUZZodNyDDz0LPXHZXp8uopXRIu2aCzCdI1hLtn2YWcaTxSGeW5LY
         Szkd7OWyVMiwF7EywCF5iMoGgcRH++aUBFKPiu7ynBz+u/ChAOoQF6qCXRNGmapSn8
         uNLYRCqQKFCxABoh3wSRHNSO0rTJFgdmP8i5OE5Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.219.67]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MG9g4-1mJddl1Zue-00GaHG; Thu, 12
 Aug 2021 17:31:05 +0200
Message-ID: <e5f39aa65a0d7d72a414556eb0c182bb8dcd1691.camel@gmx.de>
Subject: Re: [tip: timers/core] hrtimer: Consolidate reprogramming code
From:   Mike Galbraith <efault@gmx.de>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Date:   Thu, 12 Aug 2021 17:31:04 +0200
In-Reply-To: <87v94ahemj.ffs@tglx>
References: <20210713135158.054424875@linutronix.de>
         <162861133759.395.7795246170325882103.tip-bot2@tip-bot2>
         <7dfb3b15af67400227e7fa9e1916c8add0374ba9.camel@gmx.de>
         <87a6lmiwi0.ffs@tglx> <877dgqivhy.ffs@tglx>
         <bc6b74396cd6b5a4eb32ff90bcc1cb059216e0f3.camel@gmx.de>
         <87v94ahemj.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bBgsQz8ncGOk7AnAL5btq3RL36uE+o643l7zSPqq3Ur4qw4Nx8Z
 3t8YFhDcSMJms//9+HL1/DAfu0F+fUkt+KLwWOjQs8hBcYONwUKmV2e6LEClilRhgRGNtjA
 tEdjlhCOTklnTOt7kc4zGnMzUaaRSEpVYtn5/iguYiHpvdtRWiXr1NXvFfgaDYsZ++U39ii
 dAkn1bW51h7CGDLkUMgkg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VBUL4Zl4eGM=:rT2nu6qpQvn+P0DYXg0z2p
 AWJ+mGtetsZzOZ9+a0HnLQP3+Hl3IA2T7+FPL0qnb4eaaqS0UjeeT4/xttpL0iQuOFjDIB2m/
 tvrzjGw7RSg/UNPTOWk1UMe6a24AZfXDI3ABuXi6GoEn0lvG6VqS9ofBkz8VPLS+Q08hOjfsN
 tp83x0Z1PaV+GHIaPKrzwkNfKEVPxsz9sgCpaoPBXsJXxZoz2Gt1ekCYccSZ1YYD98CHeJBRq
 SPJnn85JmbxC1o4aE32A8Opo8gQsOdVttqRsaNWsUqgKWcVAtSZy1JoYydJLUOCInGF5bhu/x
 wBXW3zSoJqE+dy8WciklwJTg2teS09SbpZ1a9bnF2/NZ7wRw885HhMY/0prNBIpzLLgH1VDEl
 WpzIx7VFGobUBU53t3J5Xxsd5PoMM3hWiLfuVl6qVK5ED341uQojvvXl7b+6B6q87lo3GtDX1
 ExnknpHiZIrOaafvlqZH6P8W7uSdtWZxzlPeRVQjSUjnbMJdwwAxQhbzC1jlibVWpOowrwrPN
 vnObWEaPF7FZAHPduMWgyP/gtJosPqOqNerYPOwLKeuMVOq57fYIQ4+7nqUyoeWxM6Kzqp+BL
 MCDACwr7DzpoNbiclkOTU6kWSqYjXUO2izdwcikMFoccdk1kY+D7w+W0NtQON6A/aqoZkRqaS
 iDkTpfh2Sep5UELJC8FPytoFyHx13X9Ux63pJLawsQVBmwBJJkECv8AGPEJ4dATFkC3Xixa/W
 xL0LiHCDbT1oBt4c9Vwn2Xjm8bszqTemDeO5Q2OYfdkvzGBg2BCedIWJdwA3w+F2TV8mNJfQT
 ngFtrRRuVDkFromMLYdLyU7iDCQ9z+nXVfEhpPDtbC6/ci37xYPGaqC12bjPhIgHLf8wpMvJN
 cEoy+4Qh9QdWg+rO/QJx1vngF4ts2oObt/VD5CHgOj+EX8THhXJVqlhyz5Sq07PjsJ+D3JJbC
 HwNuEXdKxMgw0l2udJI+ohR2cYGemqiiRs2otQjbWwOS3DolWxxdECrw/9U2Tm08gljjUx5QC
 Np5AqUkzIVbXQaVGck0NE63EGuJExtCvAGF6a4dEc1cIAVFYh8wTJg1wUbI8XUIkp2oYKihdA
 Ujp+JWqdQGsznozZk9DKkvJO20QdFNDtalF
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, 2021-08-12 at 17:22 +0200, Thomas Gleixner wrote:
> >
> > Config attached just in case.
>
> I rather assume it's a hardware dependency. What kind of machine are you
> using?

Desktop box is a garden variety MEDION i4790 box with an Nvidia GTX980.
Lappy is an HP Spectre 360 i5-6200U w. i915 graphics.  Very mundane.

	-Mike

