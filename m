Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B063EA786
	for <lists+linux-tip-commits@lfdr.de>; Thu, 12 Aug 2021 17:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbhHLP1s (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 12 Aug 2021 11:27:48 -0400
Received: from mout.gmx.net ([212.227.17.20]:48341 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236311AbhHLP1r (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 12 Aug 2021 11:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628782024;
        bh=IPvNKh09inpaXW5LaA5b8dgjgWRcuoeA0B1o+H8XlT0=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=gbpG3Vc8lYIN0F75dZolAvQ9BFgyazz8wJPRUM7i631Cl+UwhrGqg9wZLP0AQMXwx
         Oy10ihM0Xw54KjqBpZbsCIdolxcffwUS05z9qmncqZoJNHtXkVFF8eho7oH8+7Jenk
         SmmByG8OKnKU9aF7/bT1duIeIS4i2bdFBAuMQQDA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.219.67]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhD6g-1mjfkQ1S0g-00eJnI; Thu, 12
 Aug 2021 17:27:04 +0200
Message-ID: <4e1febb4d812ce89c818e4615ce6d151c205f728.camel@gmx.de>
Subject: Re: [tip: timers/core] hrtimer: Consolidate reprogramming code
From:   Mike Galbraith <efault@gmx.de>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Date:   Thu, 12 Aug 2021 17:27:03 +0200
In-Reply-To: <bc6b74396cd6b5a4eb32ff90bcc1cb059216e0f3.camel@gmx.de>
References: <20210713135158.054424875@linutronix.de>
         <162861133759.395.7795246170325882103.tip-bot2@tip-bot2>
         <7dfb3b15af67400227e7fa9e1916c8add0374ba9.camel@gmx.de>
         <87a6lmiwi0.ffs@tglx> <877dgqivhy.ffs@tglx>
         <bc6b74396cd6b5a4eb32ff90bcc1cb059216e0f3.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZRJfg6qbiKy4dpW0uJb+4Ksm3SaqmX/2wDCHA5G4sFjYV8s+aX4
 VK7FcmSCouMcCIgdN1JpoBEumLhuXcuxHWgZ0HNOzq/nZrSm/9QKInk77UEj5E8mtRXQg0E
 pt5vTsBi4le962skyrwhq/Tg1e+5O+b73gI8UimWaKiJOSQBTaqNgXon+NIQloOCY/MRrrk
 TwbQX4SPaLHtelqz2yI8w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y5ziwgZThRg=:lPekU0vgf1abr4nFJLXYHW
 xKbNwYAJaopDLioy0kQjbAK1bzlABOpL/OMFaO7deNotP+zZcoMOSrHIJL7CnVAzgjV57mf2A
 fwdVvb88Tj/cIDqX3eSrqExROOyhp23UmfdwV55NN7QUDbSv/oTw72M6MuUL5wBbAPtooLDsL
 hTec9IcXinX4+NQpbOFAhnR9j6XFDAOYtZamRaISbVXWaV1x8A1/KG3iYjv/l0e6yldJCafP/
 EMjg7nZxTVroP1RHDwvWm8AxDxqOgZQssMfxHBJWZ+qDsSXfJuGf2kwJIwGliTKNxGZ75D3eQ
 frCkwa3pmXV5+RQbMMYUOruQAr5AjhqvjHMJ7Svs0LXsdbTUP0mcbO8zw8dUbiStw5lN1yCeo
 9AgzmuarS1I0zUGcywr8XwgySlDaXAGanQServIAAN1Ko2V/ztmFfK1JLWBEFFTaDcW5ppvnz
 PaWr3lKeEcNreNIglSHkyKgJPRCm3yvCkHN8DaddIjRj4VB8WrqSLv9sX9fEj9/bGetIdZZL9
 IwKuqmC9ZdDU0SU7AZ9RomRDoJt46/qbvqfYX9rCa8rqCgvOUkmqzqEyJbcDCFk0CPwO1QwsW
 6jxyJCpG4LGJ/h2OWfIdQ/6LrASOxGN52RS0f5z4jV2pmPcd7RgfN+xG60Jaur4gCYSxqGbVi
 KY3aB+t9Zd0xLKNapg3MysJW1CfMaRfOibTQPtUlY5LCjzoAhfd0RTLHj6GXsbSRomEnpXlmR
 hoS6ZEe+YH1OtP6oxLt9X/4dbyGKG1xRr9JLsWRs5Yc7UwmkCXwp63vewl2JqqBipRzqvT+HC
 oZgc42CFJDHP2yg79L2O009VKGLxX2dqe4hP3zPWjbmQY53VlpxXgnxj0ncwGd+8BIzggQzqH
 0irzw7vVmlRboA55xEAdrRCsNgOxL08ktJMKczjv//WbsMvuJLiNsKmoQTv1DeBk40wrMnFJF
 YQSWszd14GXE8IvuLR03Rz1WjnQxGLb6RPMAeCVYoEySEuWSdJfaPTI5DcGIKWEEo3AntnPXd
 NDEXBZb7h9ohnlOu8X4B8ZglPNFjRzRoqoDuz4nk9LZA47kaSlJHf11CBxdnnWt4RiqkHf1eH
 8C8kmEq69OTSiUeKgwgTQlikx7RSnUHz3lI
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, 2021-08-12 at 17:04 +0200, Mike Galbraith wrote:
> On Thu, 2021-08-12 at 16:32 +0200, Thomas Gleixner wrote:
> >
> > Can you please test whether the below fixes it for you?
>
> Yes, that boots.
>
> > I have yet to find a machine which reproduces it as I really want to
> > understand which particular part is causing this.
>
> Config attached just in case.

My HP lappy bricks as well, and with tip-rt. Fix verified there too.

	-Mike

