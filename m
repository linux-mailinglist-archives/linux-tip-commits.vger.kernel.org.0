Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBBC7B59DC
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Oct 2023 20:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjJBR6u (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 2 Oct 2023 13:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjJBR6t (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 2 Oct 2023 13:58:49 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4E4D8
        for <linux-tip-commits@vger.kernel.org>; Mon,  2 Oct 2023 10:58:46 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 98e67ed59e1d1-2774874c3daso34554a91.1
        for <linux-tip-commits@vger.kernel.org>; Mon, 02 Oct 2023 10:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=happybizdata-com.20230601.gappssmtp.com; s=20230601; t=1696269526; x=1696874326; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lx3rGq7xkfpJfugVxIhCG8q+j0sp54c0pLA6F3q0y6Y=;
        b=HbUzHZWKilX0D/60gIOZxxJEoFaLfrX2GW6B4u996Q+PCgymab2fDqHCfyxW39rZbD
         j2ykBHnlXNe6eC3LxHYdsumI/gLRqdOu1m4beuM33KEdT+tCBu+hljDV/8mlVgaxBmia
         Mj0XsTSctZDLyB6TwO94Kd+H/RTHCP5Ok3A/zBnoSIIO8x5bG7H2C2KKE98pM3xDKbE0
         1H0a2Uzg81xhtdXX1poYasKxR+EqzyW6OHj+GNiA84kMow//590J/BmsSm9GiNDDBcmI
         2r2R45mimlqOfAC2HJHx02VAEwH2IzURuX146ic7k2ZYfWBqs4+8hranBB+G43BZagMT
         dm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696269526; x=1696874326;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lx3rGq7xkfpJfugVxIhCG8q+j0sp54c0pLA6F3q0y6Y=;
        b=cF/ulDpVMa/57Ep+HZacPVVQfCRu7br/L/Lf04RbpuwR6hsBVqOMZF6WrP4ZddQIY8
         wB5vjmYmkcVJ6K+I95ARruQ8ySk8Lqk9jl2Iag81dlHZVORms1z5O+xifPsq6U7LZb8C
         tk5vBQ7fdZASrOtuKg70i9evathNH8Y1DPA1t5d8ta62gsV16/8Hx9ylwSfFtgfZAOfi
         rnhIwyyVxB/U0sF9qY4FTOc67Zq+y++SP+880lxLsLvwiFYK2YEfis2iAlR+NmZAyu0/
         aU1Sq9kFhSjxvwooE5adAdS8zb9+koeQdx85blQhPLXBJFTTtBGZ6aOQlcv1cDwfWeV1
         udZw==
X-Gm-Message-State: AOJu0YxDYMP9q+6KAkUJbdEiF1o5BCFV/APZYEHywDqWSopTokOdmELG
        4vZRCv4jwM8GII3oVyiR5UJDTo5YpBM3aJuoQXjMVQ==
X-Google-Smtp-Source: AGHT+IE/Laa7rLx2V594Ztsf6S+kH7UMPiw7qk2OQu47pnit9fNeS16w6+MRe0gQQcYoWY2gBXGHDUy5vXGR7pHloMA=
X-Received: by 2002:a17:90a:3dc5:b0:274:c284:c83c with SMTP id
 i63-20020a17090a3dc500b00274c284c83cmr9756264pjc.48.1696269526133; Mon, 02
 Oct 2023 10:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAMh3ZMJ_yEt0YCimcbJ+BwwJSX+PGktO6dGS1gmSQ1snAUqVpg@mail.gmail.com>
In-Reply-To: <CAMh3ZMJ_yEt0YCimcbJ+BwwJSX+PGktO6dGS1gmSQ1snAUqVpg@mail.gmail.com>
From:   Sofia Gonzales <sofia@happybizdata.com>
Date:   Mon, 2 Oct 2023 12:58:34 -0500
Message-ID: <CAMh3ZMJhP9rjxpdYwOiBRfg+0x40EutyKKhst9CWvKC2voHLtA@mail.gmail.com>
Subject: Re: HIMSS Global Health Conference Email List 2023
To:     Sofia Gonzales <sofia@happybizdata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Hi,

How you=E2=80=99re doing today? Did you have the chance to review my previo=
us
email with the follow up below request, I am wondering if it actually
reached you.

Kindly let me know your interest on this

Thanks and waiting for your response.

Kind Regards,
Sofia Gonzales
Marketing Coordinator

On Mon, 25 Sept 2023 at 10:14, Sofia Gonzales <sofia@happybizdata.com> wrot=
e:
>
> Hi,
>
> Would you be interested in acquiring the Healthcare Information and
> Management Systems Society Email List?
>
> Number of Contacts: 45,486
> Cost: $1,918
>
> Interested? Email me back; I would love to provide more information on th=
e list.
>
> Kind Regards,
> Sofia Gonzales
> Marketing Coordinator
